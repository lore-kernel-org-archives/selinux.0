Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5K99HrT025629
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 05:09:17 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5K9966w015996
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 09:09:06 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 20 Jun 2004 09:08:55 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BbxiG-0003Ew-Ix
	for selinux@tycho.nsa.gov; Sun, 20 Jun 2004 08:30:04 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BbyH0-0003zC-Qu
	for selinux@tycho.nsa.gov; Sun, 20 Jun 2004 09:05:58 +0000
Date: Sun, 20 Jun 2004 09:05:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: weird issue: double reboot required with errors on multi-partition system 
Message-ID: <20040620090558.GR362@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya,

i have a strange issue whereby on file system errors that are
corrected at boot time, i require a double reboot in order to
fix the problem.

scenario:

1) computer or user goes awol and power-cycle is required or just
   actioned anyway with prejudice or by accident or "act of god".

2) fsck is run but there are errors that cannot be corrected,
   manual intervention is required.

   [btw at present, i get an "access denied" avc error on login at
    the emergency "type root password or press CONTROL-D to continue"
	thing!  i've had to enable forced fsck checking!]

2a) ... or a fsck is run in "forced" yes,yes,yes mode, see
	/etc/default/rcS.

3) sometimes i get the "file system errors, reboot required" thing.

4) fsck is re-run after the optional reboot, this time it goes
   to do the other partitions.

5) this is the key: after the fsck, i find that commands like
   "wc" etc. which are on /usr (/dev/hda5) are "avc" denied access.

6) the system attempts to go into runlevel 2, and pauses for several
   minutes.

7) usually i get bored after 15 seconds of inactivity, press
   ctrl-alt-delete and it switches to runlevel 6.

   more "avc" messages related to /usr (/dev/hda5) and /var
   (/dev/hda6) being completely inaccessible.

8) reboot - everything is fine.

now, why would file system errors cause _unrelated_ partitions
to not be accessible?

*curious*.

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
