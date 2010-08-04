Message-ID: <SNT139-w19A4E7C27E07A637FFA086ABAF0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c20d3abf-1ab3-4784-85f1-e9ddbec78789_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: Question about "rootcontext=" mount option on /dev
Date: Wed, 4 Aug 2010 10:04:42 +0000
In-Reply-To: <1280839668.31604.11.camel@moss-pluto.epoch.ncsc.mil>
References: 
 <1280434836.813159.22406.nullmailer@UDistro.exmeritus.com.>,,<1280752804.8704.33.camel@moss-pluto.epoch.ncsc.mil>,<SNT139-w3339B55C06590028402BACABAE0@phx.gbl>,<1280839668.31604.11.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c20d3abf-1ab3-4784-85f1-e9ddbec78789_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

> Subject: Re: Question about "rootcontext=" mount option on /dev
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Date: Tue, 3 Aug 2010 08:47:48 -0400
> 
> On Tue, 2010-08-03 at 09:44 +0000, TaurusHarry wrote:
> > Hi SELinux experts,
> > 
> > I have run into a file context label problem on the 2.6.34 kernel.
> > After logging in, I can see the tmpfs is mounted on /dev
> > by /sbin/start_udev with the "rootcontext" option:
> > 
> > none /dev tmpfs
> > rw,rootcontext=system_u:object_r:device_t:s0,seclabel,relatime,mode=755 0 0
> > 
> > However, the /sbin/start_udev passes no such rootcontext option when
> > calling the mount command:
> > 
> >         mount -n -o mode=0755 -t devtmpfs none "$udev_root"
> > 2>/dev/null \
> >         || mount -n -o mode=0755 -t tmpfs none "$udev_root"
> >         if [ -n "$selinuxfs" -a -x /sbin/restorecon ]; then
> >                 /sbin/restorecon -R /dev
> >         fi
> > 
> > Which resulting in some device nodes in /dev/ maybe inappropriately
> > labeled, for example, the /! dev/null will be labeled as "device_t"
> > rather than "null_device_t", and I will run into below error messages
> > after logging in:
> > ...
> > -sh: /dev/null: Permission denied
> > -sh: /dev/null: Permission denied
> > root@localhost:/root> dmesg | grep avc
> > ...
> > type=1400 audit(1280386917.802:171): avc:  denied  { write } for
> > pid=932 comm="sh" name="null" dev=tmpfs ino=5012
> > scontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255
> > tcontext=system_u:object_r:device_t:s0
> > ...
> > 
> > I guess the rootcontext=xxx:device_t option will block the tmpfs
> > mounted on /dev/ to be properly labeled, am I right? Is the SELinux
> > kernel driver appends such option by default? (since I couldn't find
> > such mount option in any of system initscripts) and how could I stop
> > it being used? BTW, such problem doesn't exist on 2.6.27 kernel, the
> > tmpfs will be mounted onto /dev without the rootcontext option so that
> > the successive call of " /sbin/restorecon -R /dev" could fix /dev/*
> > labels properly.! 
> > 
> > Any comment is greatly appreciated.
> 
> The rootcontext= mount option is added by /sbin/mount.tmpfs; see
> https://bugzilla.redhat.com/show_bug.cgi?id=476964
> 
> That ensures that the root directory of the tmpfs mount is labeled
> consistently with wherever it is mounted.  It does not prevent
> restorecon from working.  So something else is preventing the restorecon
> from executing or succeeding.
> 

Yes, you are right, even if I removed the rootcontext= option from /sbin/mount.tmpfs, the /dev/null won't be properly labeled as null_device_t but still as device_t. So the problem is not in mount.tmpfs.

> Are you sure this worked on 2.6.27 with a tmpfs mount, and not with a
> devtmpfs mount?
> 

Yes, I am using tmpfs, not devtmpfs.

I have put some debugging sentences in start_udev script, around the code segment to mount tmpfs onto /dev, before tmpfs is mounted, the original native device node of /dev/console and /dev/null have the right labels:

crw-rw----  root root system_u:object_r:console_device_t:s0 /dev/console
crw-rw-rw-  root root system_u:object_r:null_device_t:s0 /dev/null

And after tmpfs is mounted, the original device nodes under /dev would be disappeared and have to be re-created by udev,  however, it seems to fail to label the /dev/null properly:(below are their labels I see after logging in)

sh-3.2# ls -Z /dev/null /dev/console
crw-------  root root system_u:object_r:console_device_t:s0 /dev/console
crw-rw-rw-  root root system_u:object_r:device_t:s0    /dev/null

I will go study carefully how the /dev/console and /dev/null are re-created and how the former gets the right label but the latter doesn't.

Best regards,
Harry


> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_c20d3abf-1ab3-4784-85f1-e9ddbec78789_
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
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi Stephen,<br><br>&gt; Subject: Re: Question about "rootcontext=" mount option on /dev<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Date: Tue, 3 Aug 2010 08:47:48 -0400<br>&gt; <br>&gt; On Tue, 2010-08-03 at 09:44 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi SELinux experts,<br>&gt; &gt; <br>&gt; &gt; I have run into a file context label problem on the 2.6.34 kernel.<br>&gt; &gt; After logging in, I can see the tmpfs is mounted on /dev<br>&gt; &gt; by /sbin/start_udev with the "rootcontext" option:<br>&gt; &gt; <br>&gt; &gt; none /dev tmpfs<br>&gt; &gt; rw,rootcontext=system_u:object_r:device_t:s0,seclabel,relatime,mode=755 0 0<br>&gt; &gt; <br>&gt; &gt; However, the /sbin/start_udev passes no such rootcontext option when<br>&gt; &gt; calling the mount command:<br>&gt; &gt; <br>&gt; &gt;         mount -n -o mode=0755 -t devtmpfs none "$udev_root"<br>&gt; &gt; 2&gt;/dev/null \<br>&gt; &gt;         || mount -n !
 -o mode=0755 -t tmpfs none "$udev_root"<br>&gt; &gt;         if [ -n "$selinuxfs" -a -x /sbin/restorecon ]; then<br>&gt; &gt;                 /sbin/restorecon -R /dev<br>&gt; &gt;         fi<br>&gt; &gt; <br>&gt; &gt; Which resulting in some device nodes in /dev/ maybe inappropriately<br>&gt; &gt; labeled, for example, the /! dev/null will be labeled as "device_t"<br>&gt; &gt; rather than "null_device_t", and I will run into below error messages<br>&gt; &gt; after logging in:<br>&gt; &gt; ...<br>&gt; &gt; -sh: /dev/null: Permission denied<br>&gt; &gt; -sh: /dev/null: Permission denied<br>&gt; &gt; root@localhost:/root&gt; dmesg | grep avc<br>&gt; &gt; ...<br>&gt; &gt; type=1400 audit(1280386917.802:171): avc:  denied  { write } for<br>&gt; &gt; pid=932 comm="sh" name="null" dev=tmpfs ino=5012<br>&gt; &gt; scontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>&gt; &gt; tcontext=system_u:object_r:device_t:s0<br>&gt; &gt; ...<br>&gt; &gt; <br>&gt; &gt; I guess the rootcontext=xxx:!
 device_t option will block the tmpfs<br>&gt; &gt; mounted on /dev/ to 
be properly labeled, am I right? Is the SELinux<br>&gt; &gt; kernel driver appends such option by default? (since I couldn't find<br>&gt; &gt; such mount option in any of system initscripts) and how could I stop<br>&gt; &gt; it being used? BTW, such problem doesn't exist on 2.6.27 kernel, the<br>&gt; &gt; tmpfs will be mounted onto /dev without the rootcontext option so that<br>&gt; &gt; the successive call of " /sbin/restorecon -R /dev" could fix /dev/*<br>&gt; &gt; labels properly.! <br>&gt; &gt; <br>&gt; &gt; Any comment is greatly appreciated.<br>&gt; <br>&gt; The rootcontext= mount option is added by /sbin/mount.tmpfs; see<br>&gt; https://bugzilla.redhat.com/show_bug.cgi?id=476964<br>&gt; <br>&gt; That ensures that the root directory of the tmpfs mount is labeled<br>&gt; consistently with wherever it is mounted.  It does not prevent<br>&gt; restorecon from working.  So something else is preventing the restorecon<br>&gt; from executing or succeeding.<br>&gt; <br><br>Yes,!
  you are right, even if I removed the rootcontext= option from /sbin/mount.tmpfs, the /dev/null won't be properly labeled as null_device_t but still as device_t. So the problem is not in mount.tmpfs.<br><br>&gt; Are you sure this worked on 2.6.27 with a tmpfs mount, and not with a<br>&gt; devtmpfs mount?<br>&gt; <br><br>Yes, I am using tmpfs, not devtmpfs.<br><br>I have put some debugging sentences in start_udev script, around the code segment to mount tmpfs onto /dev, before tmpfs is mounted, the original native device node of /dev/console and /dev/null have the right labels:<br><br>crw-rw----&nbsp; root root system_u:object_r:console_device_t:s0 /dev/console<br>crw-rw-rw-&nbsp; root root system_u:object_r:null_device_t:s0 /dev/null<br><br>And after tmpfs is mounted, the original device nodes under /dev would be disappeared and have to be re-created by udev,&nbsp; however, it seems to fail to label the /dev/null properly:(below are their labels I see after logging in)<br><!
 br>sh-3.2# ls -Z /dev/null /dev/console<br>crw-------&nbsp; root root 
system_u:object_r:console_device_t:s0 /dev/console<br>crw-rw-rw-&nbsp; root root system_u:object_r:device_t:s0&nbsp;&nbsp;&nbsp; /dev/null<br><br>I will go study carefully how the /dev/console and /dev/null are re-created and how the former gets the right label but the latter doesn't.<br><br>Best regards,<br>Harry<br><br><br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_c20d3abf-1ab3-4784-85f1-e9ddbec78789_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
