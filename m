Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14CvaRb011448
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 07:57:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i14CvY1I009167
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:57:34 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i14CvXbs009163 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 12:57:33 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SE Linux <selinux@tycho.nsa.gov>,
   ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1075897139.2267.77.camel@nb.suse.de>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
	 <1075866064.19815.57.camel@sisko.scot.redhat.com>
	 <20040204115353.GA969@vnl.com>  <1075897139.2267.77.camel@nb.suse.de>
Content-Type: text/plain
Message-Id: <1075899376.1998.14.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 12:56:17 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Wed, 2004-02-04 at 12:18, Andreas Gruenbacher wrote:

> Yes. A diff for 2.4 is attached. This is not exploitable by ordinary
> users unless selinux is used,

The leak part of it is exploitable.  It just requires you to go direct
to the syscalls.

The normal attribute-setting programs --- setfattr, setfacl and also
SELinux's chcon and setfiles --- check the value of the attr first and
don't bother trying to set it if it already has the right contents.  I
found the problem here mainly because SELinux-aware rpm did not have
that same optimisation.

But any user going direct to syscalls to set acls or attrs manually on a
file will be able to exploit the same effect.

Cheers,
 Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
