Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UGtwrT006274
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 12:55:58 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UGtu10025601
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:55:57 GMT
Date: Mon, 30 Aug 2004 18:07:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: bug in presently-developed selinux patch to udev: no acknowledgement received
Message-ID: <20040830170711.GB8382@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i noticed a bug in the last udev-selinux patch that went past
[these?] lists last week.

i sent a request for acknowldgement, and unfortunately i am very
sorry to say that i have not received an acknowledgement, and
so unfortunately i will continue to request an acknowledgement
from the people doing the redhat-based development until i
receive one.

if it wasn't important - namely that the bug in the patch will result
in incorrect policy file development for udev.te - i wouldn't bother.

the bug is that the patch merged three near-identical sections of
code that use matchpathcon(..., mode) into a function,
where mode was S_IFDIR, SF_IFLNK and S_IFsomething ...

... and the person who reworked the patch forgot to pass the mode
argument down to matchpathcon.

result: on all three instances of calling matchpathcon, the
file_contexts for DIRECTORIES will be looked up.

it was either dan or colin, and i can't remember who.

anyone who is doing udev selinux development who is NOT using
my original patch, non-optimised as it is, please be advised.

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
