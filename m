Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DAYmrT013354
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 06:34:48 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5DAYfP2006937
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 06:34:42 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 13 Jun 2004 10:34:46 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BZRhI-0002EG-Iq
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 09:54:40 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BZSHT-0006Nk-F3
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 10:32:03 +0000
Date: Sun, 13 Jun 2004 10:32:03 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kde (users) requires read permission to /var/spool/cups(/certs/0)
Message-ID: <20040613103203.GF2861@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there,

don't exactly know what this is about, but if i boot in
non-enforcing mode then i can add a local cupsys-managed
printer WITHOUT having to type in a password (a desirable
thing for a single user home office system), and i get this
in the audit logs:

	allow user_t print_spool_t:dir { search };
			#EXE=/usr/bin/kdeinit  NAME=cups   :  search

	allow user_t print_spool_t:file { getattr read };
			#EXE=/usr/bin/kdeinit  NAME=0   :  read
			#EXE=/usr/bin/kdeinit
			PATH=/var/spool/cups/certs/0   :  getattr

(i also get that damn pam system_chkpwd_t unix_verify thing but
 i can deal with that).

the file contexts are as follows:

	sez:~# ls -altr --context /var/spool/cups/certs/
	drwx--x---  root     lpadmin  system_u:object_r:print_spool_t  ..
	-r--r-----  root     lpadmin  system_u:object_r:print_spool_t  0
	drwx--x--x  root     lpadmin  system_u:object_r:print_spool_t  .

i _have_ added my single user to the lpadmin group.

as you can see, the cups developers have made an effort to provide
some sort of unixy security by removing read permission from the certs
directory and only granting read permission to the cert file.

the thing is that the only way i can imagine a workable SE/Linux
parallel to be is to have tunable.te "users_can_print_manage"
thing.

or to have a staff_printadmin_r role in a similar manner to that which
windows NT security has, matching the capability of the lpadmin unix
group.

alternatively i just create a new file context cups_spool_cert_t,
and add read-permission for users to get to it.

neither approach makes me very happy.

ideas anyone?

find out what program is really doing that spool access and provide
a domain_auto_trans to print_spool_t for it?

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
