Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EC79Ha011718
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 08:07:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6EC78H5006637
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:07:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6EC77RX006634 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:07:07 GMT
Subject: Re: patch for new release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200307122059.52553.russell@coker.com.au>
References: <200307122059.52553.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058184423.13738.572.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Jul 2003 08:07:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-07-12 at 06:59, Russell Coker wrote:
> The attached patch from Carsten was omitted from the new release.
> 
> I think that this patch is worthy of inclusion for the next release.

libsecure and the old 2.4-based SELinux userland will be obsoleted by
libselinux and the new 2.5-based SELinux userland as soon as the new API
and xattr support have been back ported.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
