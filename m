Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14KtwRb014631
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:55:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14KsUVK007022
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 20:54:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i14KsUlx007019
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 20:54:30 GMT
Subject: Re: glibc  AT_SECURE auxv
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Kratzer" <JamesK@xetron.com>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A96@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A96@s3cin>
Content-Type: text/plain
Message-Id: <1075928150.3525.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 04 Feb 2004 15:55:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-04 at 15:32, Kratzer, James R. wrote:
> >From what I've read, this glbc change is important for a production system
> and has been upstreamed into Fedora.
> So what is a Red Hat 9 2.4 kernel user to do if he wants the AT_SECURE auxv
> glibc change for a production system?  Must I upgrade from Red Hat 9 to the
> Fedora core to get this change, which is really out of the question at this
> point?  Please clarify.

You could patch and rebuild the RH9 glibc.  Or you can upgrade to Fedora
Core 1.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
