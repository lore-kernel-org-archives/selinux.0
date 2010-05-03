Subject: Re: SELinux problem on ARM: error while loading shared libraries
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy-mailing-list <refpolicy@oss1.tresys.com>
In-Reply-To: <BAY111-W3581906A9C9BD9408ADFE3ABF10@phx.gbl>
References: <BAY111-W3581906A9C9BD9408ADFE3ABF10@phx.gbl>
Content-Type: text/plain
Date: Mon, 03 May 2010 12:54:49 -0400
Message-Id: <1272905689.20339.106.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-05-02 at 04:22 +0000, TaurusHarry wrote:
> Hi SELinux experts,
> 
> Thanks for reading my questions. I am trying refpolicy-2.20091117 with
> MLS enabled on the ARM architecture and run into a huge number of
> error messages of "error while loading shared libraries: cannot
> restore segment prot after reloc: Permission denied" during system
> booting up such as:
> 
> 1. mount: error while loading shared libraries: cannot restore segment
> prot after reloc: Permission denied
> awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading
> (No such file or directory)
> awk: cmd. line:1: fatal: cannot open file `/proc/devices' for reading
> (No such file or directory)
> awk: cmd. line:1: fatal: cannot open file `/proc/misc' for reading (No
> such file or directory)
> awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading
> (No such file or directory)
> 
> 2. Enabling local filesystem quotas:  /sbin/quot! aon: error while
> loading shared libraries: cannot restore segment prot after reloc:
> Permission denied
> 
> 3. Starting sendmail: makemap: error while loading shared libraries:
> cannot restore segment prot after reloc: Permission denied
> makemap: error while loading shared libraries: cannot restore segment
> prot after reloc: Permission denied
> makemap: error while loading shared libraries: cannot restore segment
> prot after reloc: Permission denied
> makemap: error while loading shared libraries: cannot restore segment
> prot after reloc: Permission denied
> 
> 4. Starting sm-client: /usr/sbin/sendmail: error while loading shared
> libraries: cannot restore segment prot after reloc: Permission denied
> 
> 
> When I applied "enforcing=0" I could get below SELinux AVC denied
> messages about the domains of
> mount/udevd/cron/quota/sendmail/makemap/chkpwd has no "execmod"
> permissions on each of their own entry file:
> 
> 
> type=1400 audit(946684809.427:4): avc:  denie! d  { execmod } for
> pid=981 comm="mount" path="/bin/mount" d ev=mmcblk0p1 ino=32215
> scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> tcontext=system_u:object_r:mount_exec_t:s0 tclass=file
> 
> type=1400 audit(946684815.880:5): avc:  denied  { execmod } for
> pid=999 comm="udevd" path="/sbin/udevd" dev=mmcblk0p1 ino=24158
> scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> tcontext=system_u:object_r:udev_exec_t:s0 tclass=file
> 
> type=1400 audit(946684817.302:6): avc:  denied  { execmod } for
> pid=1092 comm="edd_id" path="/lib/udev/edd_id" dev=mmcblk0p1 ino=24407
> scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> tcontext=system_u:object_r:bin_t:s0 tclass=file
> 
> type=1400 audit(946684853.786:9): avc:  denied  { execmod } for
> pid=1943 comm="quotaon" path="/sbin/quotaon" dev=mmcblk0p1 ino=24269
> scontext=system_u:system_r:quota_t:s0-s15:c0.c255
> tcontext=system_u:object_r:quota_exec_t:s0 tclass=file
> 
> type=1400 audit(946684860.224:15): avc:  denied  { execmod } for
> pid=! 2028 comm="portmap" path="/sbin/portmap" dev=mmcblk0p1 ino=24229
> scontext=system_u:system_r:portmap_t:s0-s15:c0.c255
> tcontext=system_u:object_r:portmap_exec_t:s0 tclass=file
> 
> type=1400 audit(946684883.638:19): avc:  denied  { execmod } for
> pid=2139 comm="makemap" path="/usr/sbin/makemap" dev=mmcblk0p1
> ino=80801 scontext=system_u:system_r:initrc_t:s0-s15:c0.c255
> tcontext=system_u:object_r:bin_t:s0 tclass=file
> 
> type=1400 audit(946684885.661:20): avc:  denied  { execmod } for
> pid=2143 comm="newaliases" path="/usr/sbin/sendmail" dev=mmcblk0p1
> ino=80835 scontext=system_u:system_r:sendmail_t:s0-s15:c0.c255
> tcontext=system_u:object_r:sendmail_exec_t:s0 tclass=file
> 
> type=1400 audit(946684889.403:22): avc:  denied  { execmod } for
> pid=2172 comm="crond" path="/usr/sbin/crond" dev=mmcblk0p1 ino=80575
> scontext=system_u:system_r:crond_t:s0-s15:c0.c255
> tcontext=system_u:object_r:crond_exec_t:s0 tclass=file
> 
> type=1400! audit(946684890.021:24): avc:  denied  { execmod }
> for&nbsp ; pid=2190 comm="atd" path="/usr/sbin/atd" dev=mmcblk0p1
> ino=80569 scontext=system_u:system_r:crond_t:s0-s15:c0.c255
> tcontext=system_u:object_r:crond_exec_t:s0 tclass=file
> 
> type=1400 audit(946684951.974:25): avc:  denied  { execmod } for
> pid=2246 comm="unix_chkpwd" path="/sbin/unix_chkpwd" dev=mmcblk0p1
> ino=24262 scontext=system_u:system_r:chkpwd_t:s0-s15:c0.c255
> tcontext=system_u:object_r:chkpwd_exec_t:s0 tclass=file
> 
> 
> From the book of <<SELinux By Example>>, the execmod privilege is used
> to protect a process domain from executing a memory-mapped file once
> it is modified, and I know that a UNIX system normally won't do
> loading relocation for the executables but for the shared libraries, I
> don't understand why the userspace domains(for example, mount_t) would
> ever need the execmod privilege on its entry point file(mount_exec_t)?
> 
> BTW, above problems exist solely on the ARM target and I am able to
> run the same SELinux policy on! x86_64 or ppc32 targets, so I guess it
> may not be the policy itself but some architecture dependent thing
> that caused the problem.
> 
> Any comments are greatly appreciated!

Can you identify the specific ARM target and the compiler toolchain used
for it?

Sounds like it is performing text relocations on the executable.  That
could happen for example if the executable were linked with -pie but
contained an object that was not compiled with -fpic.

http://people.redhat.com/drepper/textrelocs.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
