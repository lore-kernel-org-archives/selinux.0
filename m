Subject: Re: Trying to setup a type bounds from unconfined_t and docekr_t to
 svirt_lxc_net_t
To: Daniel J Walsh <dwalsh@redhat.com>, James Carter <jwcart2@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Paul Moore <paul@paul-moore.com>
References: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
 <5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <060c3dae-0d44-d13f-6892-8966a6624c04@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 11:48:29 -0400
MIME-Version: 1.0
In-Reply-To: <5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2016 11:21 AM, Stephen Smalley wrote:
> On 04/28/2016 09:15 AM, Daniel J Walsh wrote:
>>
>> typebounds unconfined_t docker_t; # docker_t is an unconfined domain
>>
>> typebounds docker_t spc_t;  #spc_t is an unconfined domain
>>
>> typeboulds docker_t docker_lxc_net_t;
>>
>>
>> docker, rkt, systemd-nspawn, runc are all executing
>> setexeccon(svirt_lxc_net_t)
>>
>> For container domains.
>>
>> Everything works fine until I turn on expand_check in semanage.conf,
>> which we have been asked to do in Rawhide.
>>
>>
>> Attached is the current Rawhide docker policy.  And here is the output
>> from semodule -i before it crashes, with a segfault.
>>
>>
>> Had to add this rule to make it a little quieter, which is caused by a
>> rule in policy that says we allow all daemons to connecto spc_t;
>>
>> gen_require(`
>> type unconfined_t;
>> attribute daemon;
>> ')
>>
>> allow daemon unconfined_t:unix_stream_socket  connectto;
>>
>>
>> Why does typebounds care about when a domain is the target of an access,
>> I think it should only remove options when it is the source.
>>
>> Otherwise we end up having to loosen the policy to make this work.
>>
>> As long as docker_t does not have any more "allow docker_t" rules then
>> "allow unconfined_t", shouldn't this be ok?
>>
>> It seems that some or the optional code blocks are causing problems also.
> 
> I agree that typebounds is not very usable in its current form, but I'm
> not entirely clear on how to fix it.
> 
> Dropping the target bounds logic is possible; it was actually
> implemented a while back by KaiGai (see the archives) but reverted
> because of a side effect on /proc/pid file access.  Without the target
> bounds logic, you had to allow the parent domain to access all child
> domains' /proc/pid files in order for the child to access their own.
> That however could be worked around in policy, so possibly we could
> revive those patches.
> 
> However, I don't think that solves all of the problems.  For example,
> even with source bounds, I can't allow a child permissions to self or to
> its entrypoint file type or to its tmp file type without allowing those
> permissions to the parent, which may unnecessarily escalate the
> privileges of the parent or expose the parent to risk.

Actually, I think I am wrong about these statements.  You can make the
child's entrypoint type a child of the parent's entrypoint type (and
likewise for tmp file types) and then you only need to allow the parent
access to its own entrypoint and tmp types and the kernel will allow the
child access to its types.

> 
> We might need more semantics in the policy about inter-type
> relationships in order to truly evaluate bounds in a manner that permits
> such usage.  Patches/proposals welcome.
> 
> The other approach would be to use fork()+setcon()+execve() rather than
> fork()+setexeccon()+execve() in the callers.  Then you aren't subject to
> typebounds at all (NNP only restricts exec-based transitions).
