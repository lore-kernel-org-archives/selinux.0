Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14CweRb011467
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 07:58:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i14Cwd1I009199
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:58:39 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i14Cwcbs009196 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:58:39 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Russell Coker <russell@coker.com.au>,
   =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SE Linux <selinux@tycho.nsa.gov>, ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1075893298.2267.50.camel@nb.suse.de>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <1075893298.2267.50.camel@nb.suse.de>
Content-Type: text/plain
Message-Id: <1075899508.1998.16.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 12:58:28 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 11:14, Andreas Gruenbacher wrote:

> thanks for hunting this bug and for the precise analysis. The identical
> bug is in ext2 as well. I will send the attached patch to LKML & Andrew
> after verifying. Is it correct?

Looks it to me, but I'll test it.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
