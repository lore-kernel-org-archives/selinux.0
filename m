Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5CA6krT010153
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 06:06:46 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5CA6gEu006871
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 06:06:42 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 12 Jun 2004 10:06:43 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BZ4mK-00022v-7a
	for selinux@tycho.nsa.gov; Sat, 12 Jun 2004 09:26:20 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BZ5Mh-0004Ac-OQ
	for selinux@tycho.nsa.gov; Sat, 12 Jun 2004 10:03:55 +0000
Date: Sat, 12 Jun 2004 10:03:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: quickie additions to allow kde desktop to mount cdrom
Message-ID: <20040612100355.GT2861@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


in macros/user_macros.te, i added the section ifdef (`xdm.te' ...)
this is a quick hack which enables me to do the mount of a
cdrom desktop icon under KDE 3.2.2.

i have had to enable the /etc/selinux/tunable.te "user_can_mount"
thing under which this hack becomes relevant.

the write to user_home_t is to allow mount write access to
~/.xsession-errors (and probably isn't needed) but the write
to user_tmp_t is to be able to write to /tmp/kde-<username> which
IS needed.

i am sure that there are other ways to do this, i am sure that
that there are experts who forsee a problem with this approach:
all i can say is "It Works For Me (tm)".

feedback appreciated.

l.

	#
	#  Allow users to mount file systems like floppies and cdrom
	#
	mount_domain($1, $1_mount, `, fs_domain')
	role $1_r types $1_mount_t;
	r_dir_file($1_t, mnt_t)

	ifdef(`xdm.te', `
	domain_auto_trans(xdm_t, mount_exec_t, user_mount_t)
	#allow user_mount_t xdm_t:fd { use };
	#allow user_mount_t xdm_t:fifo_file { read };
	allow user_mount_t user_home_t:file { write };
	allow user_mount_t user_tmp_t:file { write };

	')

	')


-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
