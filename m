Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S8SprT008239
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 04:28:51 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6S8SKAN027109
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:28:21 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 08:27:34 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BpjI8-0000lx-CM
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 07:56:00 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BpjxI-0008J4-2M
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 09:38:32 +0100
Date: Wed, 28 Jul 2004 09:38:32 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: umount fails on shutdown: causes next boot to fail
Message-ID: <20040728083831.GC28362@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

got a bit of an issue with umount failing.

i have noticed that a double-reboot is required to clear things
if a filesystem is not unmounted at shutdown time...

... and now i have a filesystem (/var) that doesn't unmount
_even during a regular shutdown_.

i have:

- killed everything (with run_init /etc/init.d/everything stop)

- done lsof /var to double _check_ i've killed everything that
  could use /var

- done a shutdown.

- watched the shutdown messages.

- observed an "umount failed: /dev/hda6 (/var) busy"

and consequently noted that, as always, /var cannot be remounted
on startup: something somewhere in the initialisation actually
tries to _create_ /var and is told by selinux to bugger off
(fortunately), and entry into runlevel 2, as previously mentioned,
goes pear-shaped.

reboot required, and then it's all hunky-dory after that.


does anyone have _any_ clues as to why, even when there are no
files open on /var, a filesystem could not be umounted?

i think i will try again and this time actually manually try
a umount /var myself.

i really don't want to do umount -f /var but i will if i have to.

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
