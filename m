Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2HBSPRb025374
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 06:28:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2HBSO0F013300
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 11:28:24 GMT
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
        by jazzband.ncsc.mil  with SMTP id i2HBSNgZ013297 for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 11:28:23 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: newrole failed in enforcing mode
Date: Wed, 17 Mar 2004 12:27:52 +0100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200403101650.07042.carstengrohmann@gmx.de> <200403161839.13748.carstengrohmann@gmx.de> <1079460805.4583.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1079460805.4583.50.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4YDWA0nbfSZY0qa"
Message-Id: <200403171227.52632.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_4YDWA0nbfSZY0qa
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dienstag, 16. M=E4rz 2004 19:13, Stephen Smalley wrote:
> To debug the newrole failure in enforcing mode, do a 'make
> enableaudit reload' in policy and then try using newrole, and

"make enableaudit" was a good hint. The newrole domain needs read=20
access to shadow_t. The attached patch grant this by using the auth=20
attribute.=20

Greetings

Carsten
--Boundary-00=_4YDWA0nbfSZY0qa
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="newrole.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="newrole.patch"

--- macros/program/newrole_macros.te.orig	2004-03-03 13:53:26.000000000 +0100
+++ macros/program/newrole_macros.te	2004-03-17 11:47:25.506094000 +0100
@@ -10,7 +10,7 @@
 # $1_t is the domain for the program.
 # $1_exec_t is the type of the executable.
 #
-type $1_t, domain, privrole, privowner, privlog, auth_chkpwd, privfd $2;
+type $1_t, domain, privrole, privowner, privlog, auth_chkpwd, auth, privfd $2;
 in_user_role($1_t)
 role sysadm_r types $1_t;
 

--Boundary-00=_4YDWA0nbfSZY0qa--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
