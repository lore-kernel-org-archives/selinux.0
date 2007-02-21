Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LDBErZ007596
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 08:11:14 -0500
Received: from web51506.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1LDCVMD017582
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:12:31 GMT
Message-ID: <20070221131211.72950.qmail@web51506.mail.yahoo.com>
Date: Wed, 21 Feb 2007 05:12:11 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1171983969.14363.35.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I also have to wonder whether we'd be better off just switching from
>direct open+read of /proc/filesystems to just using fopen+getline,
>thereby automatically picking up glibc's internal support of dynamic
>buffer allocation and EINTR handling.  Just read the file line-by-line
>and bail out if we find selinuxfs or hit the end of file.

There might be a more robust, higher performance way of doing this. Is there ever
a situation where the selinux filesystem is _not_ "/selinux" ? If there never is
a case where this happens, then we could change over to statfs and check for
SELINUX_MAGIC in the f_type field of the structure. Its only 1 syscall instead of
several.

-Steve


 
____________________________________________________________________________________
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
http://videogames.yahoo.com/platform?platform=120121

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
