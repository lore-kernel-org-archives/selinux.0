Message-ID: <COL109-W52F185A0039BC650663F20AB0D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_53200cfd-07f6-4616-91e5-52bb2a68ae32_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>, <refpolicy@oss1.tresys.com>,
        <eparis@parisplace.org>
Subject: RE: A question about installing refpolicy-2.10081210
Date: Wed, 5 Aug 2009 06:21:48 +0000
In-Reply-To: <1249387220.9193.41.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W23743BA1B690A08216533AB0C0@phx.gbl>
 <1249387220.9193.41.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_53200cfd-07f6-4616-91e5-52bb2a68ae32_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Smalley,

After I tried out the kenrel patch you pointed out I finally could successfully boot up refpolicy-20081210! there won't have udev and mingetty error messages any more! Big thanks!

I also tried out the latest refpolicy-20090730 with the updated kernel, however, although there won't be any mingetty error messages but I did see many udev error messages still there, so I think for the time being I will just stick to the refpolicy-20081210 version.

Thank you very much!

Best regards,

Harry


> Subject: Re: A question about installing refpolicy-2.10081210
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com; eparis@parisplace.org
> Date: Tue, 4 Aug 2009 08:00:20 -0400
> 
> On Tue, 2009-08-04 at 03:00 +0000, TaurusHarry wrote:
> > Hi all,
> > 
> > I have a question about the error messages when installing
> > refpolicy-2.20081210 from the tresys website on dell 610(x86_32)
> > laptop. I have installed and compiled refpolicy-2.20081210 by the
> > following selinux user space tools:
> > 
> > libsepol-2.0.36
> > libselinux-2.0.79
> > libsemanage-2.0.27
> > policycoreutils-2.0.55
> > checkpolicy-2.0.19
> > sepolgen-1.0.16
> > 
> > Then I use kernel cmdline of "root=/dev/sda1 rw init=/bin/bash
> > selinux=1" to boot into a shell with selinux enabled so that I could
> > setup proper security contexts for the whole file system in the shell
> > before the next time I would let kernel boot into normal /sbin/init
> > program and start everything with correct security context. Then I do
> > the following commands:
> > 
> > mount -t proc none /proc
> > mount -t sysfs none /sys
> > mount -t selinuxfs none /selinux
> > SELINUXTYPE=refpolicy-20081210
> > /usr/sbin/load_policy -q /etc/selinux/$SELINUXTYPE/policy/policy.24
> > sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=$S!
> > ELINUXTYPE/" /etc/selinux/config
> > /usr/sbin/restorecon -v -R /
> > 
> > The "load_policy -q" would pop up a message of:
> > type=1403 audit(1255195933.120:2): policy loaded auid=4294967295
> > ses=4294967295
> > 
> > so I guess the policy.24 has been loaded successfully, and the
> > "restorecon" could run successfully. However, when I change the kernel
> > cmdline with "init=/sbin/init" I could see hundreds of error messages
> > about udev and mingetty such as:
> > 
> > udevd-event[1252]: selinux_setfscreatecon: matchpathcon(/dev/.tmp-8-0)
> > failed
> > udevd-event[1215]: selinux_setfilecon: matchpathcon(/dev/ram12) failed
> 
> What did you end up with as
> your /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts file?
> 
> > and 
> > 
> > type=1400 audit(1248303983.579:5559): avc:  denied  { open } for
> > pid=3283 comm="mingetty" name="var" dev=sda1 ino=103169
> > scontext=system_u:system_r:getty_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:var_t:s0 tclass=dir
> > type=1400 audit(1248303983.598:5560): avc:  denied  { open } for
> > pid=3282 comm="mingetty" name="var" dev=sda1 ! ino=103169
> > scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=
> > system_u:object_r:var_t:s0 tclass=dir
> 
> That's a kernel bug.  Kernel version?  Fixed by:
> http://marc.info/?l=git-commits-head&m=123049921710331&w=2
> http://marc.info/?l=git-commits-head&m=123809417718576&w=2
> 
> If you can't fix your kernel, then disable open permission in your
> policy (remove policycap open_perms; from policy/policy_capabilities).
> 
> > with "INIT: no more processes left in this runlevel" in the end when I
> > try to login through serial console.
> > 
> > I guess above error messages may have resulted in the file system
> > having not been labeled correctly, does anyone know what I may have
> > missed out when trying to relabeling the file system when first time
> > booting into the shell?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

_________________________________________________________________
上Windows Live 中国首页，下载最新版Messenger！
http://www.windowslive.cn
--_53200cfd-07f6-4616-91e5-52bb2a68ae32_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
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
</style>
</head>
<body class='hmmessage'>
Hi Smalley,<br><br>After I tried out the kenrel patch you pointed out I finally could successfully boot up refpolicy-20081210! there won't have udev and mingetty error messages any more! Big thanks!<br><br>I also tried out the latest refpolicy-20090730 with the updated kernel, however, although there won't be any mingetty error messages but I did see many udev error messages still there, so I think for the time being I will just stick to the refpolicy-20081210 version.<br><br>Thank you very much!<br><br>Best regards,<br><br>Harry<br><br><br>&gt; Subject: Re: A question about installing refpolicy-2.10081210<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com; eparis@parisplace.org<br>&gt; Date: Tue, 4 Aug 2009 08:00:20 -0400<br>&gt; <br>&gt; On Tue, 2009-08-04 at 03:00 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi all,<br>&gt; &gt; <br>&gt; &gt; I have a question about the error messages when install!
 ing<br>&gt; &gt; refpolicy-2.20081210 from the tresys website on dell 610(x86_32)<br>&gt; &gt; laptop. I have installed and compiled refpolicy-2.20081210 by the<br>&gt; &gt; following selinux user space tools:<br>&gt; &gt; <br>&gt; &gt; libsepol-2.0.36<br>&gt; &gt; libselinux-2.0.79<br>&gt; &gt; libsemanage-2.0.27<br>&gt; &gt; policycoreutils-2.0.55<br>&gt; &gt; checkpolicy-2.0.19<br>&gt; &gt; sepolgen-1.0.16<br>&gt; &gt; <br>&gt; &gt; Then I use kernel cmdline of "root=/dev/sda1 rw init=/bin/bash<br>&gt; &gt; selinux=1" to boot into a shell with selinux enabled so that I could<br>&gt; &gt; setup proper security contexts for the whole file system in the shell<br>&gt; &gt; before the next time I would let kernel boot into normal /sbin/init<br>&gt; &gt; program and start everything with correct security context. Then I do<br>&gt; &gt; the following commands:<br>&gt; &gt; <br>&gt; &gt; mount -t proc none /proc<br>&gt; &gt; mount -t sysfs none /sys<br>&gt; &gt; mount -t selinux!
 fs none /selinux<br>&gt; &gt; SELINUXTYPE=refpolicy-20081210<br>&gt; &
gt; /usr/sbin/load_policy -q /etc/selinux/$SELINUXTYPE/policy/policy.24<br>&gt; &gt; sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=$S!<br>&gt; &gt; ELINUXTYPE/" /etc/selinux/config<br>&gt; &gt; /usr/sbin/restorecon -v -R /<br>&gt; &gt; <br>&gt; &gt; The "load_policy -q" would pop up a message of:<br>&gt; &gt; type=1403 audit(1255195933.120:2): policy loaded auid=4294967295<br>&gt; &gt; ses=4294967295<br>&gt; &gt; <br>&gt; &gt; so I guess the policy.24 has been loaded successfully, and the<br>&gt; &gt; "restorecon" could run successfully. However, when I change the kernel<br>&gt; &gt; cmdline with "init=/sbin/init" I could see hundreds of error messages<br>&gt; &gt; about udev and mingetty such as:<br>&gt; &gt; <br>&gt; &gt; udevd-event[1252]: selinux_setfscreatecon: matchpathcon(/dev/.tmp-8-0)<br>&gt; &gt; failed<br>&gt; &gt; udevd-event[1215]: selinux_setfilecon: matchpathcon(/dev/ram12) failed<br>&gt; <br>&gt; What did you end up with as<br>&gt; your /etc/selinux/$SELINUXTYPE/cont!
 exts/files/file_contexts file?<br>&gt; <br>&gt; &gt; and <br>&gt; &gt; <br>&gt; &gt; type=1400 audit(1248303983.579:5559): avc:  denied  { open } for<br>&gt; &gt; pid=3283 comm="mingetty" name="var" dev=sda1 ino=103169<br>&gt; &gt; scontext=system_u:system_r:getty_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:var_t:s0 tclass=dir<br>&gt; &gt; type=1400 audit(1248303983.598:5560): avc:  denied  { open } for<br>&gt; &gt; pid=3282 comm="mingetty" name="var" dev=sda1 ! ino=103169<br>&gt; &gt; scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=<br>&gt; &gt; system_u:object_r:var_t:s0 tclass=dir<br>&gt; <br>&gt; That's a kernel bug.  Kernel version?  Fixed by:<br>&gt; http://marc.info/?l=git-commits-head&amp;m=123049921710331&amp;w=2<br>&gt; http://marc.info/?l=git-commits-head&amp;m=123809417718576&amp;w=2<br>&gt; <br>&gt; If you can't fix your kernel, then disable open permission in your<br>&gt; policy (remove policycap open_perms; from policy/policy_capabilit!
 ies).<br>&gt; <br>&gt; &gt; with "INIT: no more processes left in this
 runlevel" in the end when I<br>&gt; &gt; try to login through serial console.<br>&gt; &gt; <br>&gt; &gt; I guess above error messages may have resulted in the file system<br>&gt; &gt; having not been labeled correctly, does anyone know what I may have<br>&gt; &gt; missed out when trying to relabeling the file system when first time<br>&gt; &gt; booting into the shell?<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br><br /><hr />搜索本应是快乐的，不是么?  快乐搜索，有问必应！微软隆重推出! <a href='http://bing.com.cn?FORM=M00HCN&Publ=WLHMTAG&Crea=TEXT_Search_Where_You_Are_1X1' target='_new'>立即试用！</a></body>
</html>
--_53200cfd-07f6-4616-91e5-52bb2a68ae32_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
