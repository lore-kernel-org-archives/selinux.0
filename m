Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SL1erT014385
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 17:01:40 -0400 (EDT)
Received: from smtp812.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SL1cXs015439
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 21:01:38 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp812.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 21:01:23 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bpv3q-0000rd-9o
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 20:30:02 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bpviv-0004tC-Eo
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 22:12:29 +0100
Date: Wed, 28 Jul 2004 22:12:29 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: pear-shaped behaviour after enough make reloads
Message-ID: <20040728211229.GB18711@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i thought i should report what might be quite a serious issue.

the procedure i use for development of policy files is to do
_stacks_ of edits, _stacks_ of make reloads, stacks of
audit2allow -d -v -l > /tmp/foo, analyse the results and put
the appropriate ones into the new policy.

after enough make reloads, the behaviour of my system starts to get
a bit wonky.

for example, i'm doing an executable that is used by hotplug, and
a domain_auto_trans into that new executable's domain...

... yet occasionally i see what looks like evidence of the
domain_auto_trans FAILING.

the GUI users cannot run any programs when this happens.

sometimes if i switch to the GUI (from the console) the screen
goes blank; although i can still use existing ssh connections,
i cannot initiate any new ones.

after a reboot in such circumstances, i find that my system
is pretty much unusable: i have to run a ldconfig to fix a
problem of libraries being not found - things like that.

sometimes i will do a make -C /etc/selinux relabel just to be
sure.

i have to say: this only occurs if i do about ten or twenty
make reloads in a row.

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
