Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SJi3rT010351
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 15:44:04 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SJh1uK005997
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 19:43:01 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id BBA3BBF7C
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 20:43:42 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CCIa7-0003CF-N5
	for selinux@tycho.nsa.gov; Tue, 28 Sep 2004 15:03:51 +0100
Date: Tue, 28 Sep 2004 15:03:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse + setfilecon - need some userspace / libselinux1 assistance
Message-ID: <20040928140351.GA12119@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i'm not entirely sure what is going on, so thought i'd best ask.

i'm adding xattr support to fuse (*gibber*) so that i can do selinux
permissions properly.

therein immediately lies the problem: the userspace implementation of
getxattr is fine (one might hope) but the userspace implementation of
setxattr is not fine.

why?  well, because a setxattr("security.selinux", <somegarbage>)
operation is performed!

as i found out, that is banned, esp. as the userspace program is run as
getfsuid() to the user.


consequently, i looked around and found the util "setfilecon" which uses
setfilecon().

to my surprise, i found that the argv[] arguments were simply ...
typecast from a char* to a security_context_t.

surely... that's rather unexpected behaviour that could, in the
future, break applications?

well, anyway, what i've done is to check that the string is
"security.selinux" and then to call setfilecon() and that seems to work
fine.



secondly, and this is quite an important one for security reasons: the
fusermount program must be run setuid to root, in order to allow
users to _un_mount their own filesystem.

the fusermount program, whilst running as root, removes all "linux
capabilities" _except_ that of the ability to unmount.

and it also does a setfsuid and setfsgid to the user.

so, my question is: what possible horrors could i encounter,
given that setfsuid and setfilecon are involved?

will the setfilecon operation occur _as_ the user specified under the
setfsuid() uid?

or will the setfilecon operation be actioned as root?

i believe it to be really important that the answer is
"the setfilecon() is done as the setfsuid() uid"!

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
