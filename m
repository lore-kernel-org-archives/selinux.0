Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o739huKl012232
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2010 05:44:03 -0400
Received: from snt0-omc3-s24.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o739hxAL021936
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2010 09:43:59 GMT
Message-ID: <SNT139-w3339B55C06590028402BACABAE0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f8f46b9d-ae5c-474e-8362-908601348f87_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Question about "rootcontext=" mount option on /dev
Date: Tue, 3 Aug 2010 09:44:02 +0000
In-Reply-To: <1280752804.8704.33.camel@moss-pluto.epoch.ncsc.mil>
References: 
 <1280434836.813159.22406.nullmailer@UDistro.exmeritus.com.>,<1280752804.8704.33.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_f8f46b9d-ae5c-474e-8362-908601348f87_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

I have run into a file context label problem on the 2.6.34 kernel. After logging in, I can see the tmpfs is mounted on /dev by /sbin/start_udev with the "rootcontext" option:

none /dev tmpfs rw,rootcontext=system_u:object_r:device_t:s0,seclabel,relatime,mode=755 0 0

However, the /sbin/start_udev passes no such rootcontext option when calling the mount command:

        mount -n -o mode=0755 -t devtmpfs none "$udev_root" 2>/dev/null \
        || mount -n -o mode=0755 -t tmpfs none "$udev_root"
        if [ -n "$selinuxfs" -a -x /sbin/restorecon ]; then
                /sbin/restorecon -R /dev
        fi

Which resulting in some device nodes in /dev/ maybe inappropriately labeled, for example, the /dev/null will be labeled as "device_t" rather than "null_device_t", and I will run into below error messages after logging in:
...
-sh: /dev/null: Permission denied
-sh: /dev/null: Permission denied
root@localhost:/root> dmesg | grep avc
...
type=1400 audit(1280386917.802:171): avc:  denied  { write } for  pid=932 comm="sh" name="null" dev=tmpfs ino=5012 scontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255 tcontext=system_u:object_r:device_t:s0
...

I guess the rootcontext=xxx:device_t option will block the tmpfs mounted on /dev/ to be properly labeled, am I right? Is the SELinux kernel driver appends such option by default? (since I couldn't find such mount option in any of system initscripts) and how could I stop it being used? BTW, such problem doesn't exist on 2.6.27 kernel, the tmpfs will be mounted onto /dev without the rootcontext option so that the successive call of " /sbin/restorecon -R /dev" could fix /dev/* labels properly.

Any comment is greatly appreciated.

Thanks,
Harry
 		 	   		  
--_f8f46b9d-ae5c-474e-8362-908601348f87_
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
Hi SELinux experts,<br><br>I have run into a file context label problem on the 2.6.34 kernel. After logging in, I can see the tmpfs is mounted on /dev by /sbin/start_udev with the "rootcontext" option:<br><br>none /dev tmpfs rw,rootcontext=system_u:object_r:device_t:s0,seclabel,relatime,mode=755 0 0<br><br>However, the /sbin/start_udev passes no such rootcontext option when calling the mount command:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount -n -o mode=0755 -t devtmpfs none "$udev_root" 2&gt;/dev/null \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || mount -n -o mode=0755 -t tmpfs none "$udev_root"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n "$selinuxfs" -a -x /sbin/restorecon ]; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/restorecon -R /dev<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br><br>Which resulting in some device nodes in /dev/ maybe inappropriately labeled, for example, the /!
 dev/null will be labeled as "device_t" rather than "null_device_t", and I will run into below error messages after logging in:<br>...<br>-sh: /dev/null: Permission denied<br>-sh: /dev/null: Permission denied<br>root@localhost:/root&gt; dmesg | grep avc<br>...<br>type=1400 audit(1280386917.802:171): avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=932 comm="sh" name="null" dev=tmpfs ino=5012 scontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255 tcontext=system_u:object_r:device_t:s0<br>...<br><br>I guess the rootcontext=xxx:device_t option will block the tmpfs mounted on /dev/ to be properly labeled, am I right? Is the SELinux kernel driver appends such option by default? (since I couldn't find such mount option in any of system initscripts) and how could I stop it being used? BTW, such problem doesn't exist on 2.6.27 kernel, the tmpfs will be mounted onto /dev without the rootcontext option so that the successive call of " /sbin/restorecon -R /dev" could fix /dev/* labels properly.!
 <br><br>Any comment is greatly appreciated.<br><br>Thanks,<br>Harry<br
> 		 	   		  </body>
</html>
--_f8f46b9d-ae5c-474e-8362-908601348f87_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
