Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i560BWrT027530
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 20:11:32 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i560BURQ027790
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 20:11:30 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 00:11:30 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWkbv-0000tI-6F
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 23:29:59 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWlDZ-0001kJ-CI
	for selinux@tycho.nsa.gov; Sun, 06 Jun 2004 00:08:53 +0000
Date: Sun, 6 Jun 2004 00:08:53 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: successful cupsys admin: advantages of running pam_selinux
Message-ID: <20040606000852.GA6673@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

it is with some amazement that, by adding pam_selinux to /etc/pam.d/cups
and by adding an ordinary user to the lpadmin group that i was able
to have that ordinary user set up a local printer and actually print
to it (openoffice).

i am aware that there are concerns about pam_selinux being inappropriate
for certain things - openssh being one of them due to ttys not being
managed properly, and kdm when you set AutoLogin is another.

however the prospect of having to code up a policy for doing what i
just managed to do fills me with some trepidation.

i could not tell you where to begin to get the same effect as the
lpadmin group.

six of one, half a dozen of the other.

i mention all this just in case someone thought "i know, pam_selinux
is bad, let's drop it entirely".

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
