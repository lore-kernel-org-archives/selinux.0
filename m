Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i524NnrT001289
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 00:23:49 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i534NYeD017938
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 00:23:34 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 12:23:48 -0000
Date: Tue, 1 Jun 2004 12:21:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: dpkg-reconfigure xserver-xfree86
Message-ID: <20040601122114.GI8312@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

russell, hi,

ah ha, you missed one :)

i frequently use dpkg-reconfigure xserver-xfree86 to reconfig X.

and of course a run_init /etc/init.d/kdm restart throws a wobbly
because the /etc/X11/XF86Config-4 file is owned by
root:sysadm_r:sysadm_t instead of system_u:...

so!

the setfiles trigger, /etc/dpkg/postinst.d/selinux, needs to
be re-run after people use dpkg-reconfigure.

[luke smiles widely - or more specifically, turns corners of
 mouth up and shows lots of teeth]

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
