Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5QM8JrT006023
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2004 18:08:19 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5QM85AP022970
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2004 22:08:06 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 26 Jun 2004 22:07:17 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BeKk7-00041h-Qg
	for selinux@tycho.nsa.gov; Sat, 26 Jun 2004 21:29:47 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BeLH9-0001Xc-Dj
	for selinux@tycho.nsa.gov; Sat, 26 Jun 2004 22:03:55 +0000
Date: Sat, 26 Jun 2004 22:03:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fsck deleting extended attributes
Message-ID: <20040626220355.GL3559@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i was wondering if anyone had any ideas about how to deal with
fsck deleting extended attributes in order to repair the filesystem?

the issue is that if a system is switched off without shutdown and
the filesystem is damaged, such that some extended attributes are
deleted on an fsck, that's it - the file cannot be accessed!


i am setting up a system where the users will NOT be told what
the root password is, nor will they be given a user login
(they will be given an automatic KDE login), and there is
ABSOLUTELY no chance of either user support or admin support.

[someone might crack the root password, well, good luck to them].

in other words, if it breaks, and i haven't thought of a way to fix
it (by adding a "recovery" option) then it's Game Over.


what should i do?

a) get fsck.ext2 fixed?

b) forcibly run make -C /etc/selinux relabel from /etc/init.d/checkfs.sh

c) other.

i am sure that other people are / will come across this one, at some
point...

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
