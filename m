Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i55DNArT025989
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 09:23:10 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i55DN722024759
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 09:23:08 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 5 Jun 2004 13:23:08 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWaUO-0000p8-8I
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 12:41:32 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWb66-0001Tr-Uh
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 13:20:30 +0000
Date: Sat, 5 Jun 2004 13:20:30 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: exim4 patches and policy
Message-ID: <20040605132030.GY3856@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

well, i added in some basic patches to exim4 to get it to execv
to programs of a different name depending on various purposes,
whereever i could find an execv in the source code.

... but i don't exactly know what purposes to use!

i made one which goes on the exim4 -MC option (transport),
another which goes on the daemon if it gets kill -HUP'd
and so exim4 should be started as /usr/sbin/exim4-daemon

another one for exim4 -bi for alias database rebuilding.

and another one for exim4 smtp incoming called exim4-in.

that leaves exim4 itself when symlinked as /usr/sbin/sendmail
for creation of a client-side usage to deliver mail.

for reference, russell's idea is to have exim4 execv to
different program names for its various different purposes,
and to have on a non-selinux system symlinks and on an
selinux system tiny programs that change domain context
and exec to exim4.

so.

what should i do?  how do i go about creating exim4 policies
for these symlink thingummies?

does anyone have a mini program that will change to the required
domain and exec its arguments?

can someone point me in the direction of some example code that would
do these little domain transitions?

because i tried installing postfix and it's not quite there.

and after a pause of 30 seconds to deliver mail even on a local
system i'd forgotten why i hate sendmail.

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
