Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18048
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 10:08:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA21946
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 15:07:50 GMT
Received: from mail.outstep.com (a904j637.tower.wayne.edu [141.217.140.65])
	by jazzswing.ncsc.mil  with ESMTP id PAA21942
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 15:07:50 GMT
Message-ID: <1652.192.168.1.12.1014735791.squirrel@192.168.1.2>
Date: Tue, 26 Feb 2002 10:03:11 -0500 (EST)
Subject: Re: pptp and SELinux errors
From: "Lonnie Cumberland" <lonnie@outstep.com>
To: <sds@tislabs.com>
In-Reply-To: <Pine.GSO.4.33.0202251703420.16566-100000@raven>
References: <Pine.GSO.4.33.0202251703420.16566-100000@raven>
Cc: <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I now have the pppd_te files that you were talking about, but was
wondering if it would be easier to just add the pptp daemon to a
domain that already had these permissions as you have previously
mentioned?

If so then how might I go about that?

My basic project is to all my VPN connections using the VPN software
pptp from

 http://poptop.lineo.com/

which relies on the ppp stuff.

------------------------------------------------------------------
Feb 26 09:58:34 tarus pptpd[3936]: CTRL: Client 192.168.1.12 control
connection started
Feb 26 09:58:34 tarus pptpd[3936]: CTRL: Starting call (launching
pppd, opening GRE)
Feb 26 09:58:34 tarus kernel:
Feb 26 09:58:34 tarus kernel: avc:  denied  { create } for  pid=3936
exe=/usr/sbin/pptpctrl scontext=root:sysadm_r:sysadm_t
tcontext=root:sysadm_r:sysadm_t tclass=rawip_socket
Feb 26 09:58:34 tarus kernel:
Feb 26 09:58:34 tarus kernel: avc:  denied  { bind } for  pid=3936
exe=/usr/sbin/pptpctrl lport=47 scontext=root:sysadm_r:sysadm_t
tcontext=root:sysadm_r:sysadm_t tclass=rawip_socket
Feb 26 09:58:34 tarus kernel:
Feb 26 09:58:34 tarus kernel: avc:  denied  { connect } for  pid=3936
exe=/usr/sbin/pptpctrl laddr=192.168.1.7 lport=47
scontext=root:sysadm_r:sysadm_t tcontext=root:sysadm_r:sysadm_t
tclass=rawip_socket
Feb 26 09:58:34 tarus kernel:
Feb 26 09:58:34 tarus kernel: avc:  denied  { read write } for
pid=3937 exe=/usr/sbin/pppd path=/dev/ppp dev=03:02 ino=33955
scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t
tclass=chr_file
Feb 26 09:58:34 tarus pppd[3937]: pppd 2.4.1 started by root, uid 0
Feb 26 09:58:35 tarus modprobe: modprobe: Can't locate module tty-
ldisc-3
Feb 26 09:58:35 tarus pppd[3937]: Couldn't set tty to PPP discipline:
Invalid argument
Feb 26 09:58:35 tarus pppd[3937]: Exit.
Feb 26 09:58:35 tarus pptpd[3936]: GRE: read
(fd=4,buffer=804d8c0,len=8196) from PTY failed: status = -1 error =
Input/output error
Feb 26 09:58:35 tarus pptpd[3936]: CTRL: PTY read or GRE write failed
(pty,gre)=(4,5)
Feb 26 09:58:35 tarus pptpd[3936]: CTRL: Client 192.168.1.12 control
connection finished
--------------------------------------------------------------------

These are my lates set up errors from my /var/log/messages file.

Cheers,
Lonnie

-- 
 Lonnie Cumberland
 OutStep Technologies Incorporated
 EMAIL: Lonnie@OutStep.com
      : Lonnie_Cumberland@yahoo.com

 The Basis Express Virtual Office
               &
 Data Backup and Recovery Services

 URL: http://www.basis-express.com

"The Virtual Office without boundries!!!"





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
