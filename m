Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NNGtrT022287
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 19:16:55 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NNGAAS005553
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 23:16:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id C6C23BF6F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:16:54 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 00659-05-2 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 00:16:52 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8614FBF2F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:16:52 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzOEX-0004Q6-0m
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 00:28:13 +0100
Date: Tue, 24 Aug 2004 00:28:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: policy mods for xfs (to support xfstt and xfs-xtt)
Message-ID: <20040823232812.GB12720@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="St7VIuEGZ6dlpu13"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i added quite a lot of fonts, two more xfont servers and also added
some non-free truetype fonts.

this resulted in a stack more mods needed to xfs.te.

xfstt and xfs-xtt behave a bit weird for example xfstt attempts
to delete /tmp/.font-unix.

a number of truetype fonts are symlinks.

also xfstt uses a cache which i assigned to the fonts_t type, this
may not be appropriate but i was in a hurry.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfs

diff -Naur 
--- default.1.14/domains/program/xfs.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/xfs.te	2004-08-17 19:10:23.000000000 +0100
@@ -24,6 +24,7 @@
 ')
 
 allow xfs_t { etc_t etc_runtime_t }:file { getattr read };
+allow xfs_t { etc_runtime_t }:dir { getattr search };
 allow xfs_t proc_t:file { getattr read };
 
 allow xfs_t self:process setpgid;
@@ -38,5 +39,37 @@
 allow xfs_t xfs_t:unix_dgram_socket create_socket_perms;
 
 # Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
-allow xfs_t fonts_t:dir search;
-allow xfs_t fonts_t:file { getattr read };
+# xfstt to access var/cache/xfstt and truetype somewhere
+allow xfs_t fonts_t:dir { getattr read search };
+allow xfs_t fonts_t:file { getattr read write };
+
+allow xfs_t var_lib_t:dir { search };
+	#EXE=/usr/X11R6/bin/xfs  NAME=lib   :  search
+
+allow xfs_t fonts_t:file { write };
+	#EXE=/usr/bin/xfstt  NAME=ttinfo.dir   :  write
+
+allow xfs_t tmp_t:dir { remove_name write };
+	#EXE=/usr/bin/xfstt  NAME=tmp   :  write
+	#EXE=/usr/bin/xfstt  NAME=tmp   :  write
+	#EXE=/usr/bin/xfstt  NAME=.font-unix   :  remove_name
+	#EXE=/usr/bin/xfstt  NAME=tmp   :  write
+	#EXE=/usr/bin/xfstt  NAME=.font-unix   :  remove_name
+
+allow xfs_t xfs_tmp_t:dir { remove_name rmdir search write };
+	#EXE=/usr/X11R6/bin/xfs  NAME=.font-unix   :  search
+	#EXE=/usr/X11R6/bin/xfs-xtt  NAME=.font-unix   :  search
+	#EXE=/usr/X11R6/bin/xfs  NAME=.font-unix   :  search
+	#EXE=/usr/X11R6/bin/xfs  NAME=.font-unix   :  write
+	#EXE=/usr/X11R6/bin/xfs  NAME=fs7100   :  remove_name
+	#EXE=/usr/bin/xfstt  NAME=.font-unix   :  rmdir
+	#EXE=/usr/X11R6/bin/xfs  NAME=.font-unix   :  search
+	#EXE=/usr/X11R6/bin/xfs  NAME=.font-unix   :  write
+	#EXE=/usr/X11R6/bin/xfs  NAME=fs7100   :  remove_name
+	#EXE=/usr/bin/xfstt  NAME=.font-unix   :  rmdir
+
+allow xfs_t fonts_t:lnk_file { read };
+	#EXE=/usr/X11R6/bin/xfs-xtt  NAME=luximb.ttf   :  read
+	#EXE=/usr/X11R6/bin/xfs-xtt  NAME=luximb.ttf   :  read
+	#EXE=/usr/X11R6/bin/xfs  NAME=luximb.ttf   :  read
+
diff -Naur 
--- default.1.14/file_contexts/program/xfs.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/xfs.fc	2004-08-14 20:52:10.000000000 +0100
@@ -1,3 +1,5 @@
 # xfs
 /tmp/\.font-unix(/.*)?		system_u:object_r:xfs_tmp_t
 /usr/X11R6/bin/xfs	--	system_u:object_r:xfs_exec_t
+/usr/X11R6/bin/xfs-xtt	--	system_u:object_r:xfs_exec_t
+/usr/bin/xfstt		--	system_u:object_r:xfs_exec_t
diff -Naur 
--- default.1.14/file_contexts/types.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/types.fc	2004-08-23 10:35:18.000000000 +0100
@@ -396,6 +404,8 @@
 # Fonts dir
 #
 /usr/X11R6/lib/X11/fonts(/.*)?		system_u:object_r:fonts_t
+/var/lib/msttcorefonts(/.*)?		system_u:object_r:fonts_t
+/var/cache/xfstt(/.*)?			system_u:object_r:fonts_t
 /usr/share/fonts(/.*)?			system_u:object_r:fonts_t
 /usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
 

--St7VIuEGZ6dlpu13--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
