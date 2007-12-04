Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4BHwSo031998
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 06:17:58 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4BHv44018212
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 11:17:57 GMT
Received: from ns.i.cz (brana.i.cz [193.179.36.134])
	by vidle.i.cz (Postfix) with ESMTP id 50BE51CC38
	for <selinux@tycho.nsa.gov>; Tue,  4 Dec 2007 12:17:56 +0100 (CET)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 2B0B85C05
	for <selinux@tycho.nsa.gov>; Tue,  4 Dec 2007 12:17:56 +0100 (CET)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1IzVml-0007sG-SX
	for selinux@tycho.nsa.gov; Tue, 04 Dec 2007 12:17:55 +0100
Date: Tue, 4 Dec 2007 12:17:55 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: refpolicy HEAD, Debian, ioctl on xconsole by syslogd
Message-ID: <20071204111755.GB27359@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
when starting syslogd by init script:

audit(1196761642.698:3): avc:  denied { ioctl } for  pid=1353
comm="syslogd" name="xconsole" dev=tmpfs ino=3703
scontext=system_u:system_r:syslogd_t:s0
tcontext=system_u:object_r:xconsole_device_t:s0 tclass=fifo_file 

attached patch, that xserver_rw_console() gives ioctl permission.
Can be merged?
Regards
-- 
Zito

--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xconsole.patch"

Index: policy/modules/services/xserver.if
===================================================================
--- policy/modules/services/xserver.if	(revision 2539)
+++ policy/modules/services/xserver.if	(working copy)
@@ -773,7 +773,7 @@
 		type xconsole_device_t;
 	')
 
-	allow $1 xconsole_device_t:fifo_file { getattr read write };
+	allow $1 xconsole_device_t:fifo_file { getattr read write ioctl };
 ')
 
 ########################################

--dDRMvlgZJXvWKvBx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
