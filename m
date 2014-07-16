Message-ID: <53C6CBD8.2050509@tycho.nsa.gov>
Date: Wed, 16 Jul 2014 15:00:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53C01CDD.80407@tresys.com>
 <53C409C3.3010602@tycho.nsa.gov> <53C40B13.9030907@tycho.nsa.gov>
 <53C40E8D.8070006@tycho.nsa.gov> <53C40F73.3030204@tresys.com>
 <53C41818.5000906@tycho.nsa.gov> <53C5875E.3050600@tresys.com>
 <53C68950.3050805@tycho.nsa.gov> <53C68A6D.80500@tycho.nsa.gov>
 <53C68BAE.4000303@tycho.nsa.gov> <53C68D40.8020700@tycho.nsa.gov>
 <53C69616.3040808@tresys.com> <1405526012.12577.9.camel@x220.localdomain>
In-Reply-To: <1405526012.12577.9.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/16/2014 11:53 AM, Dominick Grift wrote:
> On Wed, 2014-07-16 at 11:11 -0400, Steve Lawrence wrote:
> <snip>
>> Hmm. I still can't get this error. The only thing I get with ausearch is
>>
>> type=USER_AVC msg=audit(1405522202.264:463): pid=1 uid=0 auid=4294967295
>> ses=4294967295  subj=system_u:system_r:init_t:s0 msg='Unknown permission
>> start for class system exe="/usr/lib/systemd/systemd" sauid=0 hostname=?
>> addr=? terminal=?'
>>
>> Which looks correct. Fedora's latest policy does not include start in
>> the system class:
>>
>> $ seinfo -csystem -x
>>    system
>>       status
>>       module_request
>>       reboot
>>       disable
>>       enable
>>       undefined
>>       ipc_info
>>       syslog_read
>>       halt
>>       reload
>>       syslog_console
>>       syslog_mod
>>
>> Also, the policy built with CIL on my machine allows the USER_AVC you're
>> seeing:
>>
>> $ sesearch -A -s systemd_logind_t -t init_t -c service
>> Found 2 semantic av rules:
>>    allow systemd_domain init_t : service { stop status reload start } ;
>>    allow systemd_logind_t init_t : service status ;
>>
>>
>>
>> Not sure if this would help, but it looks like you can set the boot
>> parameter systemd.log_level=debug, and it should print all the selinux
>> access checks, including which ones cause the "SELinux policy denies
>> access" message. Unfortunately, I think the extra debug messages
>> prevents my VM from booting, but you might have better luck.
>>
> 
> The same symptoms as with the classorder issue except that this time it
> only happens once after the upgrade. Rebooting fixes the issue (?)
> 
> That was not the case with the classorder issue.

$ yum reinstall checkpolicy* libsepol* libsemanage* libselinux*
policycoreutils* selinux-policy-targeted
$ cp -a /sys/fs/selinux/class class.orig
$ make -C selinux LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
install-pywrap relabel
$ ./selinux/libsemanage/utils/semanage_migrate_etc_to_var.py
$ cp -a /sys/fs/selinux/class class.new
$ diff -ru class.orig class.new

Lots of differences in permission values.
