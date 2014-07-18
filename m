Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6IGcEvN021562
 for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2014 12:38:14 -0400
References: <1405643284.28501.YahooMailNeo@web120705.mail.ne1.yahoo.com>
 <53C91F83.10603@tycho.nsa.gov>
 <1405693718.71577.YahooMailNeo@web120701.mail.ne1.yahoo.com>
 <53C93D9A.2060902@tycho.nsa.gov>
Message-ID: <1405701306.14070.YahooMailNeo@web120705.mail.ne1.yahoo.com>
Date: Fri, 18 Jul 2014 09:35:06 -0700
From: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: why does kernel call setenforce
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux ML <selinux@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <53C93D9A.2060902@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Friday, July 18, 2014 9:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 07/18/2014 10:28 AM, Andy Ruch wrote:
>>  Thank you for the information. I see MAC_STATUS audits after a user calls 
> setenforce but not during the boot process.
> 
> That would be consistent with a denial in enforcing mode; in that case,
> the operation bails with EACCES and you will not generate the MAC_STATUS
> audit message since no status change occurred.
> 
>>  Here's a few more details. I install my custom policy during the post 
> phase of the kickstart. After this, every time I boot I get the following 
> audits:
>> 
>> 
>>  type=KERNEL msg=audit(1405633146.496:1): initialized
>>  type=MAC_POLICY_LOAD msg=audit(1405633148.645:2): policy loaded 
> auid=4294967295 ses=4294967295
>>  type=SYSCALL msg=audit(1405633148.645:2): arch=c000003e syscall=1 
> success=yes exit=532798 a0=4 a1=7fa844c72000 a2=8213e a3=7fff6fce66d0 items=0 
> ppid=1 pid=771 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 
> fsgid=0 tty=(none) ses=4294967295 comm="load_policy" 
> exe="/sbin/load_policy" subj=system_u:system_r:kernel_t:s0 key=(null)
>> 
>> 
>>  I will then update my policy using "rpm -Uvh". When I boot after 
> that, I get:
>> 
>>  type=KERNEL msg=audit(1405633594.481:1): initialized
>>  type=MAC_POLICY_LOAD msg=audit(1405633596.598:2): policy loaded 
> auid=4294967295 ses=4294967295
>>  type=SYSCALL msg=audit(1405633596.598:2): arch=c000003e syscall=1 
> success=yes exit=532798 a0=4 a1=7f58faf11000 a2=8213e a3=7fffaee3b2f0 items=0 
> ppid=1 pid=731 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 
> fsgid=0 tty=(none) ses=4294967295 comm="load_policy" 
> exe="/sbin/load_policy" subj=system_u:system_r:kernel_t:s0 key=(null)
> 
> So policy was loaded by /sbin/load_policy, presumbly invoked by a script
> from the initramfs with the -i option.  This is specific to the way in
> which RHEL 6 loads policy, which differs from RHEL 5 (or RHEL 7) as each
> one had its own init system (SysVinit -> upstart -> systemd) and RHEL 6
> chose to do it from the initramfs rather than from upstart IIRC.
> 
>>  type=AVC msg=audit(1405633596.632:3): avc:  denied  { setenforce } 
> for  pid=772 comm="init" scontext=system_u:system_r:kernel_t:s0 
> tcontext=system_u:object_r:security_t:s0 tclass=security
>>  type=SYSCALL msg=audit(1405633596.632:3): arch=c000003e syscall=1 
> success=no exit=-13 a0=1 a1=19d1b80 a2=2 a3=0 items=0 ppid=1 pid=772 
> auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
> tty=(none) ses=4294967295 comm="init" exe="/bin/dash" 
> subj=system_u:system_r:kernel_t:s0 key=(null)
> 
> That's an odd one; normally enforcing mode would already have been set
> by load_policy -i so I do not know why dash is trying to set it here.
> And I assume it must be trying to set it to permissive while it is
> already enforcing, since a) we only check setenforce permission if the
> new value differs from the old, and b) the system call would only fail
> if we were already enforcing.  I don't know if dash is trying to set
> permissive to match your /etc/selinux/config (is it permissive or
> enforcing?) or because it is trying to bail into some emergency shell or
> what.  I downloaded the CentOS 6.5 dash src rpm but I do not see that it
> even calls setenforce anywhere.  What's your dash and dracut version?
> 
> 
>>  This is when I boot into enforcing mode. When I change to boot into 
> permissive, I don't see the AVC anymore. I would have expected to see the 
> AVC but have it still allowed like normal permissive-mode behavior. Could this 
> be related to having "selinux=1 enforcing=1" in the grub boot 
> arguments? But why doesn't it happen when I initially install the system?
> 
> So if you boot with enforcing=1, then the kernel starts in enforcing
> mode and load_policy -i should not try to change the enforcing mode at
> all even if /etc/selinux/config says SELINUX=permissive.  So any
> subsequent attempt to switch to permissive by any of the initramfs
> scripts will trigger a setenforce check and will fail if you have not
> allowed kernel_t to do this.
> 
> If you boot without enforcing=1, then the kernel starts in permissive
> mode, load_policy -i should set the enforcing mode to match
> /etc/selinux/config.  If /etc/selinux/config says permissive, then
> you'll stay permissive and any subsequent setenforce 0 will be a no-op
> and will not trigger a setenforce check at all.  If /etc/selinux/config
> says enforcing, then you should see the same behavior as with
> enforcing=1 if an initramfs script tries to setenforce 0.
>

I always keep the boot parameter and /etc/selinux/config in sync, i.e. both permissive or both enforcing.

Package versions:

dash-0.5.5.1-4.el6.x86_64
dracut-004-336.el6_5.2.noarch
dracut-kernel-004-336.el6_5.2.noarch
dracut-fips-004-336.el6_5.2.noarch


As for the system, everything seems to work fine even with denying setenforce. The new policy gets loaded correctly. That's why I called this more of an educational question. I was just curious why setenforce was being called only after a policy RPM update.
