Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71ELXrT007183
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:21:33 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71EL152022430
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 14:21:01 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 14:21:32 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrGjm-0002Et-K8
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 13:50:54 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrHO8-00049s-Ka
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 15:32:36 +0100
Date: Sun, 1 Aug 2004 15:32:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: user-directory _is_ home directory
Message-ID: <20040801143236.GA15949@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, got a good one for you.

... i notice that genhomedircon is working properly (hurrah)

however, it brings me a slight problem.

i've made /home _the_ home directory: there is one user, it's
_the_ user.

i could alternatively make a ln -s from /home/theoneuser to /c or
something but that would drive me up the wall because it is so
... so.... windows.

my question is: does anyone have any recommendations on how to deal
with /home being a mount point, and also being a user's home directory.

naively i removed the HOME_ROOT macro from types.fc, and naturally,
the /home mount point doesn't.  mount, that is.

clues anyone?

live with oh, say, restoring it /home/theoneuser instead, and
creating a symlink as "/MyDocuments" or something stupid?

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
