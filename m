Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA00453
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 16:37:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA17242
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 21:34:40 GMT
Received: from ziplip.com (mail.ziplip.com [128.242.109.119])
	by jazzswing.ncsc.mil  with ESMTP id VAA17238
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 21:34:40 GMT
Message-ID: <DTCOIKAKKNB3NWCMMKNXKJCDHTEAEFP3JRHWOJAF@ziplip.com>
Date: Sun, 16 Feb 2003 13:36:02 -0800 (PST)
From: Dusty Hall <draper7@ziplip.com>
Reply-To: draper7@ziplip.com
To: SELinux@tycho.nsa.gov
Subject: Re: spasswd.c
Cc: russell@coker.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell,

  Thanks for the fix, it worked like a champ.  Although now I'm having problems compiling disk-utils, specifically raw.c.  The following is the error message:

cc -O -pipe -O2 -m486 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0 -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  -s  raw.c   -o raw
raw.c:22: linux/raw.h: No such file or directory
raw.c: In function `main':
raw.c:121: `RAW_MAJOR' undeclared (first use in this function)
raw.c:121: (Each undeclared identifier is reported only once
raw.c:121: for each function it appears in.)
raw.c: In function `query':
raw.c:187: storage size of `rq' isn't known
raw.c:191: `RAW_GETBIND' undeclared (first use in this function)
raw.c:187: warning: unused variable `rq'
raw.c: In function `bind':
raw.c:209: storage size of `rq' isn't known
raw.c:215: `RAW_SETBIND' undeclared (first use in this function)
raw.c:209: warning: unused variable `rq'
make: *** [raw] Error 1

Sorry to keep buggin you guys but I really would like to test it out.  I guess what I really need to do is learn C.  As usual thanks for any help.

Later,

-Dusty
draper7@<NOSPAM>ziplip.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
