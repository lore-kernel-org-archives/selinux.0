Subject: Re: load_policy memory error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201108182256.15760.russell@coker.com.au>
References: <201108182256.15760.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Aug 2011 09:13:42 -0400
Message-ID: <1313673222.21331.14.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-18 at 22:56 +1000, Russell Coker wrote:
> type=MAC_POLICY_LOAD msg=audit(1313671617.326:131533): policy loaded 
> auid=4294967295 ses=4294967295
> type=SYSCALL msg=audit(1313671617.326:131533): arch=c000003e syscall=1 
> success=no exit=-131941357240360 a0=4 a1=7f9a74e90010 a2=8a8b6 a3=0 items=0 
> ppid=3607 pid=3617 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 
> sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="load_policy" 
> exe="/sbin/load_policy" subj=unconfined_u:unconfined_r:load_policy_t:s0-
> s0:c0.c1023 key=(null)
> 
> Running Debian/Squeeze in a Xen DomU with stock versions of everything other 
> than the policy I got the below error which corresponded with the above 
> audit.log entries.
> 
> # semodule -i ./localmilter.pp
> SELinux:  Could not load policy file /etc/selinux/default/policy/policy.24:  
> Invalid argument
> /sbin/load_policy:  Can't load policy:  Invalid argument
> libsemanage.semanage_reload_policy: load_policy returned error code 2.
> semodule:  Failed!
> 
> I repeated the same semodule command soon afterward (with no other sysadmin 
> stuff going on in the mean time) and got the following result:
> 
> type=MAC_POLICY_LOAD msg=audit(1313671700.498:131534): policy loaded 
> auid=4294967295 ses=4294967295
> type=SYSCALL msg=audit(1313671700.498:131534): arch=c000003e syscall=1 
> success=no exit=-131941343723560 a0=4 a1=7f30a096e010 a2=8a8c2 a3=0 items=0 
> ppid=3698 pid=3706 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 
> sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="load_policy" 
> exe="/sbin/load_policy" subj=unconfined_u:unconfined_r:load_policy_t:s0-
> s0:c0.c1023 key=(null)
> 
> The kernel message log has the following, it seems that loading a 564K policy 
> on a system with 180M of RAM is causing memory problems.
> 
> Aug 18 12:46:56 sandbox kernel: [2180669.735670] load_policy: page allocation 
> failure. order:4, mode:0xc0d0
> Aug 18 12:46:56 sandbox kernel: [2180669.735885] Pid: 3614, comm: load_policy 
> Not tainted 2.6.32-5-xen-amd64 #1
> Aug 18 12:46:56 sandbox kernel: [2180669.735902] Call Trace:
> 
> # free
>              total       used       free     shared    buffers     cached
> Mem:        181084     125704      55380          0       1592      27884
> -/+ buffers/cache:      96228      84856
> Swap:       524280     193512     330768

There have been a number of commits since 2.6.32 to eliminate higher
order memory allocations from SELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
