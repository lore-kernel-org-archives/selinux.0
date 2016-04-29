Subject: Re: Trying to setup a type bounds from unconfined_t and docekr_t to
 svirt_lxc_net_t
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 James Carter <jwcart2@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Paul Moore <paul@paul-moore.com>
References: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
 <5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov>
 <f1c8b9e7-31f7-a288-415b-82eb45021420@redhat.com>
 <865845d6-a79f-e2e2-389d-48378525881b@tycho.nsa.gov>
 <4fba413b-8558-c03d-0ce6-d83e8c047b6c@redhat.com>
 <9f618ce8-7e46-e564-fa6b-317aa501a04e@tycho.nsa.gov>
 <25c300b6-b804-594b-9147-fb1bd3670a25@redhat.com>
 <768cddb7-9f6b-0b58-0a8f-db189377013f@tycho.nsa.gov>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <57231903.4020700@redhat.com>
Date: Fri, 29 Apr 2016 10:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <768cddb7-9f6b-0b58-0a8f-db189377013f@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2016 08:36 PM, Stephen Smalley wrote:
> On 04/28/2016 02:07 PM, Daniel J Walsh wrote:
>>
>>
>> On 04/28/2016 01:59 PM, Stephen Smalley wrote:
>>> On 04/28/2016 01:35 PM, Daniel J Walsh wrote:
>>>>
>>>> On 04/28/2016 01:31 PM, Stephen Smalley wrote:
>>>>> On 04/28/2016 12:20 PM, Daniel J Walsh wrote:
>>>>>> On 04/28/2016 11:21 AM, Stephen Smalley wrote:
>>>>>>> On 04/28/2016 09:15 AM, Daniel J Walsh wrote:
>>>>>>>>> typebounds unconfined_t docker_t; # docker_t is an unconfined
>>>>>>>>> domain
>>>>>>>>>
>>>>>>>>> typebounds docker_t spc_t;  #spc_t is an unconfined domain
>>>>>>>>>
>>>>>>>>> typeboulds docker_t docker_lxc_net_t;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> docker, rkt, systemd-nspawn, runc are all executing
>>>>>>>>> setexeccon(svirt_lxc_net_t)
>>>>>>>>>
>>>>>>>>> For container domains.
>>>>>>>>>
>>>>>>>>> Everything works fine until I turn on expand_check in
>>>>>>>>> semanage.conf,
>>>>>>>>> which we have been asked to do in Rawhide.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Attached is the current Rawhide docker policy.  And here is the
>>>>>>>>> output
>>>>>>>>> from semodule -i before it crashes, with a segfault.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Had to add this rule to make it a little quieter, which is caused
>>>>>>>>> by a
>>>>>>>>> rule in policy that says we allow all daemons to connecto spc_t;
>>>>>>>>>
>>>>>>>>> gen_require(`
>>>>>>>>> type unconfined_t;
>>>>>>>>> attribute daemon;
>>>>>>>>> ')
>>>>>>>>>
>>>>>>>>> allow daemon unconfined_t:unix_stream_socket  connectto;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Why does typebounds care about when a domain is the target of an
>>>>>>>>> access,
>>>>>>>>> I think it should only remove options when it is the source.
>>>>>>>>>
>>>>>>>>> Otherwise we end up having to loosen the policy to make this work.
>>>>>>>>>
>>>>>>>>> As long as docker_t does not have any more "allow docker_t" rules
>>>>>>>>> then
>>>>>>>>> "allow unconfined_t", shouldn't this be ok?
>>>>>>>>>
>>>>>>>>> It seems that some or the optional code blocks are causing
>>>>>>>>> problems also.
>>>>>>> I agree that typebounds is not very usable in its current form,
>>>>>>> but I'm
>>>>>>> not entirely clear on how to fix it.
>>>>>>>
>>>>>>> Dropping the target bounds logic is possible; it was actually
>>>>>>> implemented a while back by KaiGai (see the archives) but reverted
>>>>>>> because of a side effect on /proc/pid file access.  Without the
>>>>>>> target
>>>>>>> bounds logic, you had to allow the parent domain to access all child
>>>>>>> domains' /proc/pid files in order for the child to access their own.
>>>>>>> That however could be worked around in policy, so possibly we could
>>>>>>> revive those patches.
>>>>>>>
>>>>>>> However, I don't think that solves all of the problems.  For example,
>>>>>>> even with source bounds, I can't allow a child permissions to self
>>>>>>> or to
>>>>>>> its entrypoint file type or to its tmp file type without allowing
>>>>>>> those
>>>>>>> permissions to the parent, which may unnecessarily escalate the
>>>>>>> privileges of the parent or expose the parent to risk.
>>>>>>>
>>>>>>> We might need more semantics in the policy about inter-type
>>>>>>> relationships in order to truly evaluate bounds in a manner that
>>>>>>> permits
>>>>>>> such usage.  Patches/proposals welcome.
>>>>>>>
>>>>>>> The other approach would be to use fork()+setcon()+execve() rather
>>>>>>> than
>>>>>>> fork()+setexeccon()+execve() in the callers.  Then you aren't
>>>>>>> subject to
>>>>>>> typebounds at all (NNP only restricts exec-based transitions).
>>>>>> The entrypoints are alot simpler to fix.  I think just eliminating the
>>>>>> target checks would
>>>>>> go along way to making this a lot tighter policy.
>>>>>>
>>>>>> I have no problem with allowing parent domain access to child domains
>>>>>> self fields.  I think this
>>>>>> make some sense.  This seems a lot more secure that allowing any
>>>>>> domain
>>>>>> that can communicate
>>>>>> with the child to be able to communicate with the parent.
>>>>>>
>>>>>> With the way it works now, I can not even figure out how to
>>>>>> increase the
>>>>>> privs of unconfined_t or
>>>>>> other confined domains to actually make it work.
>>>>> Ok, let's assume that we change the libsepol and kernel logic to drop
>>>>> the target bounds checks.  What else remains to make this work?
>>>> Looking at the output from the semodule command, I see some other
>>>> strange errors like this.
>>>>
>>>>    (allow docker_t cluster_pid (sock_file (write getattr append open)))
>>>>
>>>>
>>>> I have no idea why it would complain about this.  Other then potentially
>>>> problems caused by optional policy?
>>> $ sesearch -A -s docker_t -t cluster_pid -c sock_file
>>> Found 1 semantic av rules:
>>>     allow daemon cluster_pid : sock_file { write getattr append open } ;
>>>
>>> $ sesearch -A -s unconfined_t -t cluster_pid -c sock_file
>>> <no output>
>>>
>>> So that is a legitimate violation of the bound and would be denied by
>>> the kernel if it were attempted.  Either you need to allow it to
>>> unconfined_t or tighten up that rule so that docker_t isn't included
>>> (why should all daemon domains be allowed to do that?).
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>>
>> allow files_unconfined_type file_type:{ dir lnk_file sock_file fifo_file
>> blk_file } *;
>>
>> So unless cluster_pid refers to something that is not a file_type, then
>> I think unconfined_t can do it.
>> No idea why this is allowed.
>>
>> seinfo -acluster_pid -x
>>    cluster_pid
>>       dlm_controld_var_run_t
>>       fenced_var_run_t
>>       foghorn_var_run_t
>>       gfs_controld_var_run_t
>>       haproxy_var_run_t
>>       groupd_var_run_t
>>       qdiskd_var_run_t
>>       cluster_var_run_t
> 
> Hmm...that would appear to be a bug in the libsepol hierarchy checker,
> and also in setools3 since it didn't find the match.  Just tried
> setools4 and it did find the matching rules:
> $ ./sesearch -A -s unconfined_t -t cluster_pid -c sock_file
> allow domain pidfile:sock_file { write getattr open append };
> allow files_unconfined_type file_type:sock_file { rename open execute
> execmod setattr read lock create quotaon getattr mounton write
> relabelfrom ioctl link relabelto unlink swapon audit_access append };

Ok so it is a bug in libsepol as you said because it should work
correctly if we talk about unconfined domains.

cluster_pid refers only to file_type types.

> 
> Yet another reason to switch to setools4...
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
