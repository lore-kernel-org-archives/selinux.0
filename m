Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5PJVO0S003075
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 15:31:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5PJUass009486
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 19:30:36 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
	by jazzswing.ncsc.mil  with ESMTP id h5PJUYhY009478
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 19:30:35 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 4E612F63A
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 15:31:20 -0400 (EDT)
Subject: small passwd.te zsh fixes
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-eKUTOQtimDjk3BLaPcQs"
Message-Id: <1056569473.3752.25.camel@columbia>
Mime-Version: 1.0
Date: 25 Jun 2003 15:31:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eKUTOQtimDjk3BLaPcQs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I use zsh, and on my Debian system the setup looks like:
monk:/home/walters# lc /bin/zsh*
lrwxrwxrwx  root     root     system_u:object_r:shell_exec_t   /bin/zsh -> /etc/alternatives/zsh
-rwxr-xr-x  root     root     system_u:object_r:shell_exec_t   /bin/zsh-4.0.4
-rwxr-xr-x  root     root     system_u:object_r:shell_exec_t   /bin/zsh4
monk:/home/walters# lc /etc/alternatives/zsh
lrwxrwxrwx  root     root     system_u:object_r:etc_t          /etc/alternatives/zsh -> /bin/zsh4

So in order to use schsh to change my shell to /bin/zsh (which is what's
listed in /etc/shells), I need passwd_t to be able to read both
shell_exec_t lnk_files, as well as read etc_t lnk_files.  Maybe for a
higher level of security /etc/alternatives entries could have their own
type, but that kind of seems like overkill to me.

A patch to passwd.te is attached; this is against the policy distributed
in the Debian woody packages.

--=-eKUTOQtimDjk3BLaPcQs
Content-Disposition: attachment; filename=passwd-te.patch
Content-Type: text/plain; name=passwd-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/domains/program/passwd.te	Sat May 24 =
22:07:24 2003
+++ passwd.te	Thu Jun 26 03:24:42 2003
@@ -26,13 +26,16 @@
 # Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
 allow $1_t { bin_t sbin_t }:dir r_dir_perms;
 can_exec($1_t, { bin_t sbin_t shell_exec_t passwd_real_exec_t })
+allow $1_t shell_exec_t:lnk_file read;
+# Allow etc_t symlinks for /etc/alternatives on Debian.
+allow $1_t etc_t:lnk_file read;
 allow $1_t bin_t:lnk_file read;
 r_dir_file($1_t, locale_t)
=20
 allow $1_t fs_t:filesystem getattr;
=20
 # allow checking if a shell is executable
-allow $1_t shell_exec_t:file execute;
+allow $1_t shell_exec_t:{file lnk_file} execute;
=20
 # Obtain contexts
 allow $1_t security_t:security { sid_to_context context_to_sid };

--=-eKUTOQtimDjk3BLaPcQs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
