Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17569
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 14:23:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA07978
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 18:22:00 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA07970 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 18:21:58 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "M. H." <metalhead00@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: building libsecure.a advice
Date: Wed, 28 Aug 2002 20:23:26 +0200
References: <F517f8CATwsi6PJyLHI0000cfaa@hotmail.com>
In-Reply-To: <F517f8CATwsi6PJyLHI0000cfaa@hotmail.com>
MIME-Version: 1.0
Message-Id: <20020828182327.3A6C4357C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 19:59, M. H. wrote:
> Has anyone tried to build JUST libsecure.a. Since SELinux applications need
> to be linked against it, I want to separate all necessary headers and
> libraries (seems like libsecure.a is the only one) so I can integrate them
> in my build environment (rather than relying on the default include or lib
> directories of the system.)
> A problem I've run into is finding a simple way of rebuilding the library
> without installing the whole kernel. I tried to run 'make' in the
> selinux/libsecure directory but that fails since selinux/libsecure/include
> misses some necessary files (some of those are in
> lsm-2.4/security/selinux/include.) Has anyone had any luck building ONLY
> libsecure.a?

Good suggestion, I think it would be handy to have the library code separated 
from the rest of the selinux-small code.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
