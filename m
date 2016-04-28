Subject: Re: Trying to setup a type bounds from unconfined_t and docekr_t to
 svirt_lxc_net_t
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
References: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <572226D3.8060800@tycho.nsa.gov>
Date: Thu, 28 Apr 2016 11:05:55 -0400
MIME-Version: 1.0
In-Reply-To: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2016 09:15 AM, Daniel J Walsh wrote:
>
> typebounds unconfined_t docker_t; # docker_t is an unconfined domain
>
> typebounds docker_t spc_t;  #spc_t is an unconfined domain
>
> typeboulds docker_t docker_lxc_net_t;
>
>
> docker, rkt, systemd-nspawn, runc are all executing setexeccon(svirt_lxc_net_t)
>
> For container domains.
>
> Everything works fine until I turn on expand_check in semanage.conf, which we
> have been asked to do in Rawhide.
>
>
> Attached is the current Rawhide docker policy.  And here is the output from
> semodule -i before it crashes, with a segfault.
>

The segfault has been fixed in upstream if you are able to pull in fixes at this 
point.

>
> Had to add this rule to make it a little quieter, which is caused by a rule in
> policy that says we allow all daemons to connecto spc_t;
>
> gen_require(`
> type unconfined_t;
> attribute daemon;
> ')
>
> allow daemon unconfined_t:unix_stream_socket  connectto;
>
>
> Why does typebounds care about when a domain is the target of an access, I think
> it should only remove options when it is the source.
>

This has always been the behavior. Whether that is the desirable behavior is a 
different question. To fix this would require changes in both the kernel and 
userspace.

> Otherwise we end up having to loosen the policy to make this work.
>
>
> As long as docker_t does not have any more "allow docker_t" rules then "allow
> unconfined_t", shouldn't this be ok?
>

For your case, this seems to make sense.

> It seems that some or the optional code blocks are causing problems also.
>

What problem are you having with optional blocks? Maybe the bounds error 
reporting is just confusing.

The following is showing a trace from the root of the policy down to the actual 
rule. I find it helpful, but maybe it is confusing to others.

     <root>
     optional at line 4356 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     optional at line 4651 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     optional at line 5414 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     optional at line 5494 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     optional at line 6180 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     optional at line 6192 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     booleanif at line 6201 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     true at line 6202 of /var/lib/selinux/targeted/tmp/modules/100/init/cil
     allow at line 6205 of /var/lib/selinux/targeted/tmp/modules/100/init/cil

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
