Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71Df7rT006969
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:41:07 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71DeZ52021962
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:40:35 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 13:41:06 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrG6d-0002EE-MA
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 13:10:27 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrGkz-00045e-VQ
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 14:52:09 +0100
Date: Sun, 1 Aug 2004 14:52:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: udev, tmp_t (on tmpfs on /dev), and matchpathcon failing
Message-ID: <20040801135209.GC15205@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello hello, this is with 1.14 utils and libselinux1: matchpathcon appears to be
failing ... on everything.

it says "matchpathcon(/) failed No such file or directory"

*clueless*...

okay, strace shows /etc/selinux/targeted/contexts/file_contexts
doesn't exist.

okkaay...

okay.  right.  i symlink
/etc/selinux/targeted/contexts/file_contexts/file_contexts to
/etc/selinux/src/contexts/file_contexts/file_contexts

and off it goes.

gawd, wish i'd found this earlier, i've been creating audit rules
like stonk, not knowing what was wrong.

*sigh*  okay.

russell (someone?), the debian 1.14 (or greater) selinux-policy-default
package could uhm, do with um, updating to match what the rpm spec
does :)

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
