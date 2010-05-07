Message-ID: <BAY111-W4328D1585F4AA393DB090CABF60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b181bac0-7e26-4aa1-bc1e-5e29ac5beafc_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: SELinux problem on ARM: error while loading shared libraries
Date: Fri, 7 May 2010 12:43:38 +0000
In-Reply-To: <1272905689.20339.106.camel@moss-pluto.epoch.ncsc.mil>
References: 
 <BAY111-W3581906A9C9BD9408ADFE3ABF10@phx.gbl>,<1272905689.20339.106.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_b181bac0-7e26-4aa1-bc1e-5e29ac5beafc_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Subject: Re: SELinux problem on ARM: error while loading shared libraries
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com
> Date: Mon, 3 May 2010 12:54:49 -0400
> 
> On Sun, 2010-05-02 at 04:22 +0000, TaurusHarry wrote:
> > Hi SELinux experts,
> > 
> > Thanks for reading my questions. I am trying refpolicy-2.20091117 with
> > MLS enabled on the ARM architecture and run into a huge number of
> > error messages of "error while loading shared libraries: cannot
> > restore segment prot after reloc: Permission denied" during system
> > booting up such as:
> > 
> > 1. mount: error while loading shared libraries: cannot restore segment
> > prot after reloc: Permission denied
> > awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading
> > (No such file or directory)
> > awk: cmd. line:1: fatal: cannot open file `/proc/devices' for reading
> > (No such file or directory)
> > awk: cmd. line:1: fatal: cannot open file `/proc/misc' for reading (No
> > such file or directory)
> > awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading
> > (No such file or directory)
> > 
> > 2. Enabling local filesystem quotas:  /sbin/quot! aon: error while
> > loading shared libraries: cannot restore segment prot after reloc:
> > Permission denied
> > 
> > 3. Starting sendmail: makemap: error while loading shared libraries:
> > cannot restore segment prot after reloc: Permission denied
> > makemap: error while loading shared libraries: cannot restore segment
> > prot after reloc: Permission denied
> > makemap: error while loading shared libraries: cannot restore segment
> > prot after reloc: Permission denied
> > makemap: error while loading shared libraries: cannot restore segment
> > prot after reloc: Permission denied
> > 
> > 4. Starting sm-client: /usr/sbin/sendmail: error while loading shared
> > libraries: cannot restore segment prot after reloc: Permission denied
> > 
> > 
> > When I applied "enforcing=0" I could get below SELinux AVC denied
> > messages about the domains of
> > mount/udevd/cron/quota/sendmail/makemap/chkpwd has no "execmod"
> > permissions on each of their own entry file:
> > 
> > 
> > type=1400 audit(946684809.427:4): avc:  denie! d  { execmod } for
> > pid=981 comm="mount" path="/bin/mount" d ev=mmcblk0p1 ino=32215
> > scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:mount_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684815.880:5): avc:  denied  { execmod } for
> > pid=999 comm="udevd" path="/sbin/udevd" dev=mmcblk0p1 ino=24158
> > scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:udev_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684817.302:6): avc:  denied  { execmod } for
> > pid=1092 comm="edd_id" path="/lib/udev/edd_id" dev=mmcblk0p1 ino=24407
> > scontext=system_u:system_r:udev_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:bin_t:s0 tclass=file
> > 
> > type=1400 audit(946684853.786:9): avc:  denied  { execmod } for
> > pid=1943 comm="quotaon" path="/sbin/quotaon" dev=mmcblk0p1 ino=24269
> > scontext=system_u:system_r:quota_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:quota_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684860.224:15): avc:  denied  { execmod } for
> > pid=! 2028 comm="portmap" path="/sbin/portmap" dev=mmcblk0p1 ino=24229
> > scontext=system_u:system_r:portmap_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:portmap_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684883.638:19): avc:  denied  { execmod } for
> > pid=2139 comm="makemap" path="/usr/sbin/makemap" dev=mmcblk0p1
> > ino=80801 scontext=system_u:system_r:initrc_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:bin_t:s0 tclass=file
> > 
> > type=1400 audit(946684885.661:20): avc:  denied  { execmod } for
> > pid=2143 comm="newaliases" path="/usr/sbin/sendmail" dev=mmcblk0p1
> > ino=80835 scontext=system_u:system_r:sendmail_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:sendmail_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684889.403:22): avc:  denied  { execmod } for
> > pid=2172 comm="crond" path="/usr/sbin/crond" dev=mmcblk0p1 ino=80575
> > scontext=system_u:system_r:crond_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:crond_exec_t:s0 tclass=file
> > 
> > type=1400! audit(946684890.021:24): avc:  denied  { execmod }
> > for&nbsp ; pid=2190 comm="atd" path="/usr/sbin/atd" dev=mmcblk0p1
> > ino=80569 scontext=system_u:system_r:crond_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:crond_exec_t:s0 tclass=file
> > 
> > type=1400 audit(946684951.974:25): avc:  denied  { execmod } for
> > pid=2246 comm="unix_chkpwd" path="/sbin/unix_chkpwd" dev=mmcblk0p1
> > ino=24262 scontext=system_u:system_r:chkpwd_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:chkpwd_exec_t:s0 tclass=file
> > 
> > 
> > From the book of <<SELinux By Example>>, the execmod privilege is used
> > to protect a process domain from executing a memory-mapped file once
> > it is modified, and I know that a UNIX system normally won't do
> > loading relocation for the executables but for the shared libraries, I
> > don't understand why the userspace domains(for example, mount_t) would
> > ever need the execmod privilege on its entry point file(mount_exec_t)?
> > 
> > BTW, above problems exist solely on the ARM target and I am able to
> > run the same SELinux policy on! x86_64 or ppc32 targets, so I guess it
> > may not be the policy itself but some architecture dependent thing
> > that caused the problem.
> > 
> > Any comments are greatly appreciated!
> 
> Can you identify the specific ARM target and the compiler toolchain used
> for it?
> 
> Sounds like it is performing text relocations on the executable.  That
> could happen for example if the executable were linked with -pie but
> contained an object that was not compiled with -fpic.
> 
> http://people.redhat.com/drepper/textrelocs.html
> 

Hi Stephen,

Many many thanks for your suggestions! These days I have read through the articles written by Ulrich Drepper and got a deeper understanding of execmod permission in SELinux. It turns out that my ARM cross-compiler has not handled the -pie option properly - If only the -fpie is used the executable is pure PIC code but if the -pie is used as well then the binary would require text reloc. The -pie will make the binary DYN rather than EXEC(readelf -h | grep Type) and only my ARM cross-compiler will introduce text reloc on the pair of "-fpie -pie", but other compilers such as local x86_32 compiler or ppc32 cross-compiler do not.

Now that the culprit has been found, I will figure out how to fix it next. I will update you when I make any progress.

Best regards,
Harry

> -- 
> Stephen Smalley
> National Security Agency
> 
 		 	   		  
_________________________________________________________________
一张照片的自白——Windows Live照片的可爱视频介绍
http://windowslivesky.spaces.live.com/blog/cns!5892B6048E2498BD!889.entry
--_b181bac0-7e26-4aa1-bc1e-5e29ac5beafc_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
<br><br>&gt; Subject: Re: SELinux problem on ARM: error while loading shared libraries<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com<br>&gt; Date: Mon, 3 May 2010 12:54:49 -0400<br>&gt; <br>&gt; On Sun, 2010-05-02 at 04:22 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi SELinux experts,<br>&gt; &gt; <br>&gt; &gt; Thanks for reading my questions. I am trying refpolicy-2.20091117 with<br>&gt; &gt; MLS enabled on the ARM architecture and run into a huge number of<br>&gt; &gt; error messages of "error while loading shared libraries: cannot<br>&gt; &gt; restore segment prot after reloc: Permission denied" during system<br>&gt; &gt; booting up such as:<br>&gt; &gt; <br>&gt; &gt; 1. mount: error while loading shared libraries: cannot restore segment<br>&gt; &gt; prot after reloc: Permission denied<br>&gt; &gt; awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading<br>&gt; &gt; (No such fi!
 le or directory)<br>&gt; &gt; awk: cmd. line:1: fatal: cannot open file `/proc/devices' for reading<br>&gt; &gt; (No such file or directory)<br>&gt; &gt; awk: cmd. line:1: fatal: cannot open file `/proc/misc' for reading (No<br>&gt; &gt; such file or directory)<br>&gt; &gt; awk: cmd. line:1: fatal: cannot open file `/proc/mounts' for reading<br>&gt; &gt; (No such file or directory)<br>&gt; &gt; <br>&gt; &gt; 2. Enabling local filesystem quotas:  /sbin/quot! aon: error while<br>&gt; &gt; loading shared libraries: cannot restore segment prot after reloc:<br>&gt; &gt; Permission denied<br>&gt; &gt; <br>&gt; &gt; 3. Starting sendmail: makemap: error while loading shared libraries:<br>&gt; &gt; cannot restore segment prot after reloc: Permission denied<br>&gt; &gt; makemap: error while loading shared libraries: cannot restore segment<br>&gt; &gt; prot after reloc: Permission denied<br>&gt; &gt; makemap: error while loading shared libraries: cannot restore segment<br>&gt; &gt; pr!
 ot after reloc: Permission denied<br>&gt; &gt; makemap: error while lo
ading shared libraries: cannot restore segment<br>&gt; &gt; prot after reloc: Permission denied<br>&gt; &gt; <br>&gt; &gt; 4. Starting sm-client: /usr/sbin/sendmail: error while loading shared<br>&gt; &gt; libraries: cannot restore segment prot after reloc: Permission denied<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; When I applied "enforcing=0" I could get below SELinux AVC denied<br>&gt; &gt; messages about the domains of<br>&gt; &gt; mount/udevd/cron/quota/sendmail/makemap/chkpwd has no "execmod"<br>&gt; &gt; permissions on each of their own entry file:<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684809.427:4): avc:  denie! d  { execmod } for<br>&gt; &gt; pid=981 comm="mount" path="/bin/mount" d ev=mmcblk0p1 ino=32215<br>&gt; &gt; scontext=system_u:system_r:udev_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:mount_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684815.880:5): avc:  denied  { execmod } for<br>&gt; &gt; pid=999 co!
 mm="udevd" path="/sbin/udevd" dev=mmcblk0p1 ino=24158<br>&gt; &gt; scontext=system_u:system_r:udev_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:udev_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684817.302:6): avc:  denied  { execmod } for<br>&gt; &gt; pid=1092 comm="edd_id" path="/lib/udev/edd_id" dev=mmcblk0p1 ino=24407<br>&gt; &gt; scontext=system_u:system_r:udev_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:bin_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684853.786:9): avc:  denied  { execmod } for<br>&gt; &gt; pid=1943 comm="quotaon" path="/sbin/quotaon" dev=mmcblk0p1 ino=24269<br>&gt; &gt; scontext=system_u:system_r:quota_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:quota_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684860.224:15): avc:  denied  { execmod } for<br>&gt; &gt; pid=! 2028 comm="portmap" path="/sbin/portmap" dev=mmcblk0p1 ino=24229<br>&gt; &gt; scontext=syste!
 m_u:system_r:portmap_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:o
bject_r:portmap_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684883.638:19): avc:  denied  { execmod } for<br>&gt; &gt; pid=2139 comm="makemap" path="/usr/sbin/makemap" dev=mmcblk0p1<br>&gt; &gt; ino=80801 scontext=system_u:system_r:initrc_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:bin_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684885.661:20): avc:  denied  { execmod } for<br>&gt; &gt; pid=2143 comm="newaliases" path="/usr/sbin/sendmail" dev=mmcblk0p1<br>&gt; &gt; ino=80835 scontext=system_u:system_r:sendmail_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:sendmail_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684889.403:22): avc:  denied  { execmod } for<br>&gt; &gt; pid=2172 comm="crond" path="/usr/sbin/crond" dev=mmcblk0p1 ino=80575<br>&gt; &gt; scontext=system_u:system_r:crond_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:crond_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &g!
 t; type=1400! audit(946684890.021:24): avc:  denied  { execmod }<br>&gt; &gt; for&amp;nbsp ; pid=2190 comm="atd" path="/usr/sbin/atd" dev=mmcblk0p1<br>&gt; &gt; ino=80569 scontext=system_u:system_r:crond_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:crond_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; type=1400 audit(946684951.974:25): avc:  denied  { execmod } for<br>&gt; &gt; pid=2246 comm="unix_chkpwd" path="/sbin/unix_chkpwd" dev=mmcblk0p1<br>&gt; &gt; ino=24262 scontext=system_u:system_r:chkpwd_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:chkpwd_exec_t:s0 tclass=file<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; From the book of &lt;&lt;SELinux By Example&gt;&gt;, the execmod privilege is used<br>&gt; &gt; to protect a process domain from executing a memory-mapped file once<br>&gt; &gt; it is modified, and I know that a UNIX system normally won't do<br>&gt; &gt; loading relocation for the executables but for the shared libraries, I<br>&gt; &gt; don'!
 t understand why the userspace domains(for example, mount_t) would<br>
&gt; &gt; ever need the execmod privilege on its entry point file(mount_exec_t)?<br>&gt; &gt; <br>&gt; &gt; BTW, above problems exist solely on the ARM target and I am able to<br>&gt; &gt; run the same SELinux policy on! x86_64 or ppc32 targets, so I guess it<br>&gt; &gt; may not be the policy itself but some architecture dependent thing<br>&gt; &gt; that caused the problem.<br>&gt; &gt; <br>&gt; &gt; Any comments are greatly appreciated!<br>&gt; <br>&gt; Can you identify the specific ARM target and the compiler toolchain used<br>&gt; for it?<br>&gt; <br>&gt; Sounds like it is performing text relocations on the executable.  That<br>&gt; could happen for example if the executable were linked with -pie but<br>&gt; contained an object that was not compiled with -fpic.<br>&gt; <br>&gt; http://people.redhat.com/drepper/textrelocs.html<br>&gt; <br><br>Hi Stephen,<br><br>Many many thanks for your suggestions! These days I have read through the articles written by Ulrich Drepper and!
  got a deeper understanding of execmod permission in SELinux. It turns out that my ARM cross-compiler has not handled the -pie option properly - If only the -fpie is used the executable is pure PIC code but if the -pie is used as well then the binary would require text reloc. The -pie will make the binary DYN rather than EXEC(readelf -h | grep Type) and only my ARM cross-compiler will introduce text reloc on the pair of "-fpie -pie", but other compilers such as local x86_32 compiler or ppc32 cross-compiler do not.<br><br>Now that the culprit has been found, I will figure out how to fix it next. I will update you when I make any progress.<br><br>Best regards,<br>Harry<br><br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br> 		 	   		  <br /><hr />使用Messenger保护盾2.0，支持多账号登录！ <a href='http://www.windowslive.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_b181bac0-7e26-4aa1-bc1e-5e29ac5beafc_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
