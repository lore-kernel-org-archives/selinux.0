Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA11927
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 10:12:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA13066
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 15:10:15 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id PAA13058 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 15:10:14 GMT
Date: Mon, 28 Oct 2002 16:12:07 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021028161207.B8537@lemuria.org>
References: <20021028110158.A1294@lemuria.org> <200210281324.12898.russell@coker.com.au> <20021028135809.A4521@lemuria.org> <200210281447.09486.russell@coker.com.au> <20021028150547.A7632@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
In-Reply-To: <20021028150547.A7632@lemuria.org>; from tom@lemuria.org on Mon, Oct 28, 2002 at 03:05:47PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a small patch to mysqld.te which solves the startup problem for
me and lets mysqld run without any error.
I believe these changes do not open any security problems as they don't
give init access to the databases. One could do away with the
requirement to write into the /var/lib/mysql directory with a few
changes to the safe_mysqld startup script, but I don't think it would
make much of a difference, security-wise.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mysqld.diff"

--- default/domains/program/mysqld.te   2002-10-27 02:29:00.000000000 +0200
+++ current/domains/program/mysqld.te   2002-10-28 17:32:28.000000000 +0100
@@ -26,6 +26,8 @@
 allow initrc_t var_run_mysqld_t:sock_file write;

 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
+allow initrc_t etc_mysqld_t:file { read };
+allow initrc_t mysqld_db_t:dir { write };

 allow mysqld_t self:capability { setgid setuid };
 allow mysqld_t self:process getsched;
@@ -34,7 +36,8 @@

 # Allow access to the mysqld databases
 create_dir_file(mysqld_t, mysqld_db_t)
-allow mysqld_t var_lib_t:dir search;
+allow mysqld_t var_lib_t:dir { getattr search };
+

 # read config files
 r_dir_file(mysqld_t, etc_mysqld_t)


--MW5yreqqjyrRcusr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
