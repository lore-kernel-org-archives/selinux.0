Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p31EoESx011466
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 10:50:14 -0400
Received: from cluster-a.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p31EoA9M020896
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 14:50:11 GMT
Received: from mail2.neceur.com (mail2.neceur.com [195.47.207.4])
	by rly09a.srv.mailcontrol.com (MailControl) with ESMTP id p31Eo8uL015543
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 15:50:09 +0100
Received: from intmail1.nenh.neceur.com (intmail1.nenh.neceur.com [172.29.14.11])
	by mail2.neceur.com (8.13.8/8.13.8) with ESMTP id p31Eo8XR032112
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 15:50:08 +0100
Received: from av1.neceur.com (av1.neceur.com [172.29.14.21])
	by intmail1.nenh.neceur.com (8.13.8/8.13.8) with ESMTP id p31Eo8QR003396
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 15:50:08 +0100
Received: from av1.neceur.com (unknown [127.0.0.1])
	by IMSA (Postfix) with ESMTP id 295BD20EFE2
	for <selinux@tycho.nsa.gov>; Fri,  1 Apr 2011 14:50:08 +0000 (UTC)
Received: from euexhub02.EU.NEC.COM (unknown [172.29.155.227])
	by av1.neceur.com (Postfix) with ESMTP id 11B4D20EFD0
	for <selinux@tycho.nsa.gov>; Fri,  1 Apr 2011 14:50:08 +0000 (UTC)
From: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 1 Apr 2011 15:50:04 +0100
Subject: [PATCH] libselinux: fix a noise in manpage
Message-ID: <A9F5079BABDEE646AEBDB6831725762C52B55BD75E@EUEXCLU01.EU.NEC.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In writing up security_compute_create_name description, I noticed
a noise in manpage around 80th characters in line.
It fixes the noise.

diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 8e821cf..49a6d18 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -23,8 +23,7 @@ the SELinux policy database in the kernel.
 .sp
 .BI "int security_compute_user(security_context_t "scon ", const char *" username ", security_context_t **" con );
 .sp
-.BI "int security_get_initial_context(const char *" name ", security_context_t
-"con );
+.BI "int security_get_initial_context(const char *" name ", security_context_t "con );
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp

--
NEC Europe Ltd, SAP Global Competence Center
KaiGai Kohei <kohei.kaigai@eu.nec.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
