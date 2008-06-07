Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m57DZmhH009552
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2008 09:35:48 -0400
Received: from ppsw-1.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m57DZkAs025362
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2008 13:35:47 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:41717)
	by ppsw-1.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.131]:25)
	with esmtp id 1K4ya6-00079x-5Y (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Sat, 07 Jun 2008 14:35:42 +0100
Message-ID: <484A8EAB.7030106@martinorr.name>
Date: Sat, 07 Jun 2008 14:35:39 +0100
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-16185-1212845742-0001-2"
To: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [refpolicy] Let xserver chat to hal
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-16185-1212845742-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

I get messages like:
Mar  6 18:17:38 caligula dbus: avc:  denied  { send_msg } for msgtype=signal
interface=org.freedesktop.Hal.Device member=PropertyModified
dest=org.freedesktop.DBus spid=3245 tpid=3325
scontext=system_u:system_r:hald_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=dbus

Attached patch lets xserver talk to hal by dbus.

Best wishes,

-- 
Martin Orr

--=_caligula-16185-1212845742-0001-2
Content-Type: text/plain; name="117_xserver_hal_chat"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="117_xserver_hal_chat"

Written by: Martin Orr

Let xserver talk to hal by dbus

Mar  6 18:17:38 caligula dbus: avc:  denied  { send_msg } for msgtype=signal interface=org.freedesktop.Hal.Device member=PropertyModified dest=org.freedesktop.DBus spid=3245 tpid=3325 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=dbus
Mar  6 19:21:41 caligula dbus: avc:  denied  { send_msg } for msgtype=method_call interface=org.freedesktop.Hal.Manager member=FindDeviceByCapability dest=org.freedesktop.Hal spid=3394 tpid=3314 scontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tcontext=system_u:system_r:hald_t:s0 tclass=dbus

Index: policy/modules/services/xserver.te
===================================================================
--- policy/modules/services/xserver.te.orig
+++ policy/modules/services/xserver.te
@@ -467,6 +467,10 @@
 ')
 
 optional_policy(`
+	hal_dbus_chat(xdm_xserver_t)
+')
+
+optional_policy(`
 	resmgr_stream_connect(xdm_t)
 ')
 

--=_caligula-16185-1212845742-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
