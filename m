Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5S6ah0S017677
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 02:36:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5S6ag5e021056
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 06:36:42 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h5S6af92021053 for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 06:36:42 GMT
Subject: screen.te zsh fixes
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-yxWI+Ac3mNjxDC1T4FzP"
Message-Id: <1056782197.14920.85.camel@columbia>
Mime-Version: 1.0
Date: 28 Jun 2003 02:36:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yxWI+Ac3mNjxDC1T4FzP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Similar fixes to screen.te needed for the zsh symlinks.  Patch attached.

You know though, I am thinking more and more that we should treat
/etc/alternatives specially for setfiles.  We could follow the symlink
and label it with the type of the file it points to.  That way we
wouldn't have to add all these special etc_t:{lnk_file} { read }
permissions to various programs that are able to execute bin_t or
whatever.



--=-yxWI+Ac3mNjxDC1T4FzP
Content-Disposition: attachment; filename=screen-te.patch
Content-Type: text/plain; name=screen-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/macros/program/screen_macros.te	Sat M=
ay 24 22:07:24 2003
+++ screen_macros.te	Sat Jun 28 02:32:23 2003
@@ -63,7 +63,7 @@
 allow $1_screen_t proc_t:dir search;
 allow $1_screen_t proc_t:lnk_file read;
 dontaudit $1_screen_t device_t:chr_file { getattr };
-allow $1_screen_t etc_t:file { read getattr };
+allow $1_screen_t etc_t:{file lnk_file} { read getattr };
 allow $1_screen_t self:dir { search read };
 allow $1_screen_t self:lnk_file { read };
 allow $1_screen_t device_t:dir search;
@@ -72,6 +72,7 @@
 allow $1_screen_t self:unix_stream_socket create_socket_perms;
 can_exec($1_screen_t, shell_exec_t)
 allow $1_screen_t bin_t:dir search;
+allow $1_screen_t bin_t:lnk_file { read };
=20
 dontaudit $1_screen_t file_type:{ chr_file blk_file } getattr;
 ')

--=-yxWI+Ac3mNjxDC1T4FzP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
