Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59MOvrT023283
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 18:24:57 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i59MOqP2029150
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 18:24:52 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 9 Jun 2004 22:24:51 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYArc-0001dO-Du
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 21:44:04 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYBST-0004z3-U1
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 22:22:09 +0000
Date: Wed, 9 Jun 2004 22:22:09 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [debian] - installation of mysqld requires chfn
Message-ID: <20040609222209.GH5727@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i just installed (or tried to install) mysql-server with enforcing=1
switched on.

it failed because of adding the mysql user and the use of
"chfn" to change the name to "MySql Server" in /etc/passwd.

i added the can_exec chfn_exec_t into domains/programs/dpkg.te:

	# mysqld is broken too
	ifdef(`mysqld.te', `
	can_exec(dpkg_t, chfn_exec_t)
	domain_auto_trans(dpkg_t, mysqld_exec_t, mysqld_t)
	can_unix_connect(dpkg_t, mysqld_t)
	allow mysqld_t dpkg_tmp_t:file { getattr read };
	')

... but as it turns out, i can't use chfn at all (it doesn't
have permission to write to /etc/shadow - this is version
passwd-4.0.3-8.selinux1 from dan walters) so again i had to
reboot with "enforcing=0".

so, summary:

1) patch to dpkg.te needed to get mysqld to install.

2) there's something i don't understand about why chfn is failing.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
