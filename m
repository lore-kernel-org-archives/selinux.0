Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14JQlRb014061
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 14:26:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14JPOVK026272
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 19:25:24 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i14JPOlx026269
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 19:25:24 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Russell Coker <russell@coker.com.au>,
   Andreas Gruenbacher <agruen@suse.de>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040204191142.GA11886@bunuel.tii.matav.hu>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <20040204191142.GA11886@bunuel.tii.matav.hu>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1075922729.1998.429.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 19:25:29 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 19:11, Magosányi Árpád wrote:

> Related to this same fs crash Theodore Y. Ts'o have found
> some endiannes problems in e2fslibs code. But I cannot
> get silo to use any symlinks, despite that I have recompiled
> it with the patched e2fslibs.
> 
> Can it be due to this xattr bug?

Any code that is aware of fast vs. slow symlinks will not work if the
i_blocks gets out of sync, so it's possible that that's a problem.  But
fsck (with Ted's endian fixes) should correct the i_blocks counter.  If
you still have silo problems reading after that, then there must be
something else going on.

Cheers,
 Stephen



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
