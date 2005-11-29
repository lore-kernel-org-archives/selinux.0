Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAUFWBMA026566
	for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2005 10:32:11 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAUFS4tY016114
	for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2005 15:28:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id jAUFRQSF018734
	for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2005 10:27:26 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id jAUFRQmv018733
	for selinux@tycho.nsa.gov; Wed, 30 Nov 2005 10:27:26 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jATKnHMA019131
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 15:49:23 -0500 (EST)
Received: from pne-smtpout1-sn1.fre.skanova.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jATKjPPZ005058
	for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2005 20:45:26 GMT
Received: from safari.iki.fi (80.223.105.208) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 438C7B5E00017217 for selinux@tycho.nsa.gov; Tue, 29 Nov 2005 21:45:24 +0100
Date: Tue, 29 Nov 2005 22:45:23 +0200
From: Sami Farin <safari-selinux@safari.iki.fi>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Linux 2.6.13.4 --> 2.6.14.3 & security contexts
Message-ID: <20051129204523.GA29885@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After "upgrading" from 2.6.13.4 to 2.6.14.3, selinux
stopped working as expected.
Security context is not created for new files.

For example, when I do "touch ~/hirvi ; ls -lZ ~/hirvi"
I get
-rw-rw----  safari   safari                                    /home/safari/hirvi

and after "useradd -M foobar" I have to do
"restorecon /etc/shadow* /etc/passwd* /etc/group* /etc/gshadow*"
or I can't add more users.  And "restorecon /etc/ld.so.c*"
needed after running ldconfig.

With 2.6.13.4 I used fedora's selinux-policy-targeted-1*, and
with 2.6.14.3 the same one.  When I noticed all is not fine,
I "upgraded" to serefpolicy 2.0.5.
After disabling execmem globally, it seemed to work except
that security context is not created for new files.

So, all I would like to know is how to get 2.6.13.4 behavior back
(_and_ while running 2.6.14.3) with smallest possible amount of sweat
and blood.

$ id
uid=500(safari) gid=500(safari) groups=37(rpm),500(safari),509(xuser),546(sound) context=user_u:system_r:unconfined_t:s0-s0:c0.c255

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
