Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o25LkvtP006047
	for <selinux@tycho.nsa.gov>; Fri, 5 Mar 2010 16:46:57 -0500
Received: from relay1.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o25LlMtJ016252
	for <selinux@tycho.nsa.gov>; Fri, 5 Mar 2010 21:47:22 GMT
Received: from apatlisdmfe2.core.gtri.org (apatlisdmfe2.core.gtri.org [130.207.199.71])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id 30C6D7753E3
	for <selinux@tycho.nsa.gov>; Fri,  5 Mar 2010 16:46:54 -0500 (EST)
Received: from apatlisdmfe2.core.gtri.org (apatlisdmfe2.core.gtri.org [130.207.199.71]) by relay1.gtri.gatech.edu with ESMTP id COCNxyziRMUvtxMF for <selinux@tycho.nsa.gov>; Fri, 05 Mar 2010 16:46:56 -0500 (EST)
Message-ID: <4B917BCF.7060200@gtri.gatech.edu>
Date: Fri, 5 Mar 2010 16:46:55 -0500
From: Joshua Roys <joshua.roys@gtri.gatech.edu>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [RFC][PATCH] mod_selinux: setcon earlier
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms070605000808090307020109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------ms070605000808090307020109
Content-Type: multipart/mixed;
 boundary="------------000604050500010603050301"

This is a multi-part message in MIME format.
--------------000604050500010603050301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

I am wondering if the attached patch creates the actual intended=20
behavior?  Specifically, at which point httpd calls setcon() when the=20
selinuxServerDomain option is set.

The current code ends up calling setcon after sockets have been opened,=20
at least if the prefork mpm is in use.  Here's the current path: apache=20
calls these hooks in this order: pre_config, check_config, open_logs,=20
post_config.  The prefork mpm opens the listening sockets in open_logs,=20
and mod_selinux does setcon() in post_config.  However, I noticed that=20
the selinuxServerDomain option has the EXEC_ON_READ option set...  and I =

noticed issues with labeled networking having the setcon() called after=20
the listening sockets are opened.

The attached patch deletes (well, in this version just comments out...)=20
the mod_selinux post_config hook, and calls the routine directly from=20
the set_server_domain option-processing hook.  This, because of the=20
EXEC_ON_READ option, is executed immediately upon finding a=20
selinuxServerDomain option in a httpd config file.  Thus, setcon() is=20
called before sockets are opened.

Josh

--------------000604050500010603050301
Content-Type: text/plain;
 name="setcon-earlier.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="setcon-earlier.diff"

--- mod_selinux.c.old	2010-03-03 11:40:14.886608228 -0500
+++ mod_selinux.c	2010-03-03 11:40:19.019609063 -0500
@@ -394,8 +394,10 @@
     if (is_selinux_enabled() < 1)
         return;
=20
+/*
     ap_hook_post_config(selinux_post_config,
                         NULL, NULL, APR_HOOK_MIDDLE);
+*/
     ap_hook_post_read_request(selinux_post_read_request,
                               NULL, NULL, APR_HOOK_MIDDLE);
     ap_hook_handler(selinux_handler,
@@ -470,6 +472,8 @@
 {
     server_domain =3D apr_pstrdup(cmd->pool, v1);
=20
+    selinux_post_config(NULL, NULL, cmd->temp_pool, cmd->server);
+
     return NULL;
 }
=20

--------------000604050500010603050301--

--------------ms070605000808090307020109
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FL+dJ+KDevmPhu+g4wAAAAAAAA==
--------------ms070605000808090307020109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
