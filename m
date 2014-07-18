Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6IESZvE012290
 for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2014 10:28:35 -0400
References: <1405643284.28501.YahooMailNeo@web120705.mail.ne1.yahoo.com>
 <53C91F83.10603@tycho.nsa.gov>
Message-ID: <1405693718.71577.YahooMailNeo@web120701.mail.ne1.yahoo.com>
Date: Fri, 18 Jul 2014 07:28:38 -0700
From: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: why does kernel call setenforce
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux ML <selinux@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <53C91F83.10603@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>




> On Friday, July 18, 2014 7:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 07/17/2014 08:28 PM, Andy Ruch wrote:
> 
>>  Hello,
>> 
>>  This is more of an educational question. I'm running a custom policy on 
> RHEL 6.5.
>> 
>> 
>>  Why does the kernel call setenforce only after the selinux policy RPM has 
> been updated? Out of the box, I don't see any AVCs. Once I update the 
> policy, I see an AVC for "kernel_t security_t:security setenforce". Is 
> the kernel setting SELinux to permissive or enforcing during those calls? 
> 
> By "after the selinux policy RPM has been updated", do you mean after
> you have installed your own policy?  Do you mean that this happens when
> you install your policy and reload or when you reboot after installing
> your policy?
> 
> The kernel does not call setenforce; your init program or dracut
> initramfs script does that, but it would show up in the kernel_t domain
> because it happens before switching or transitioning (depending on your
> particular init program and whether it implements the transition via
> setcon or re-exec) to the init_t domain.  Since init loads the policy
> originally, it starts in the kernel_t domain and can only
> switch/transition to the init_t domain after loading policy.
> 
> Normally this occurs upon invoking
> libselinux/src/load_policy.c:selinux_init_load_policy() from your init
> program (I think in RHEL6 a dracut selinux-loadpolicy.sh script was
> invoking load_policy -i which calls the same function).  That sets
> enforcing mode and loads policy as per your /etc/selinux/config
> settings, optionally overridden by any selinux=0 or enforcing=0
> parameters on the kernel command-line.
> 
> If your kernel was configured with CONFIG_SECURITY_SELINUX_DEVELOP=y
> (the default), then it always starts in permissive mode and must be
> switched to enforcing mode by init.  If not, then the kernel is always
> enforcing and there is no support for permissive mode at all.  However,
> regardless, until a policy is first loaded, the kernel will allow any
> requested permission.
> 
> setenforce permission is checked whenever there is a change to the
> current enforcing status, so it can show up for permissive -> enforcing
> (although that will be allowed regardless since it will be permissive at
> the point of the check) or for enforcing -> permissive (where a denial
> would prevent switching).  There should be a separate MAC_STATUS audit
> message generated upon setenforce changes that will show you the
> enforcing= and old_enforcing= values.
> 
> All that said, I'm a bit puzzled by your statement that you are seeing
> an avc message at all, as selinux_init_load_policy() calls
> security_setenforce() before loading policy, so at that point nothing
> would ever be denied since there is no policy yet.
>

Thank you for the information. I see MAC_STATUS audits after a user calls setenforce but not during the boot process. 

Here's a few more details. I install my custom policy during the post phase of the kickstart. After this, every time I boot I get the following audits:


type=KERNEL msg=audit(1405633146.496:1): initialized
type=MAC_POLICY_LOAD msg=audit(1405633148.645:2): policy loaded auid=4294967295 ses=4294967295
type=SYSCALL msg=audit(1405633148.645:2): arch=c000003e syscall=1 success=yes exit=532798 a0=4 a1=7fa844c72000 a2=8213e a3=7fff6fce66d0 items=0 ppid=1 pid=771 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="load_policy" exe="/sbin/load_policy" subj=system_u:system_r:kernel_t:s0 key=(null)


I will then update my policy using "rpm -Uvh". When I boot after that, I get:

type=KERNEL msg=audit(1405633594.481:1): initialized
type=MAC_POLICY_LOAD msg=audit(1405633596.598:2): policy loaded auid=4294967295 ses=4294967295
type=SYSCALL msg=audit(1405633596.598:2): arch=c000003e syscall=1 success=yes exit=532798 a0=4 a1=7f58faf11000 a2=8213e a3=7fffaee3b2f0 items=0 ppid=1 pid=731 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="load_policy" exe="/sbin/load_policy" subj=system_u:system_r:kernel_t:s0 key=(null)
type=AVC msg=audit(1405633596.632:3): avc:  denied  { setenforce } for  pid=772 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=security
type=SYSCALL msg=audit(1405633596.632:3): arch=c000003e syscall=1 success=no exit=-13 a0=1 a1=19d1b80 a2=2 a3=0 items=0 ppid=1 pid=772 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="init" exe="/bin/dash" subj=system_u:system_r:kernel_t:s0 key=(null)


This is when I boot into enforcing mode. When I change to boot into permissive, I don't see the AVC anymore. I would have expected to see the AVC but have it still allowed like normal permissive-mode behavior. Could this be related to having "selinux=1 enforcing=1" in the grub boot arguments? But why doesn't it happen when I initially install the system?
