Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDKYjIi007161
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 15:34:45 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDKX3Ux020608
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 20:33:04 GMT
Subject: Re: [patch] typeattribute statements
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <41BDF612.7090707@trustedcs.com>
References: <41BDBAF1.2060502@trustedcs.com>
	 <41BDF612.7090707@trustedcs.com>
Content-Type: text/plain
Message-Id: <1102969792.27895.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Dec 2004 15:29:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-13 at 15:05, Darrel Goeddel wrote:
> There is a bad call to free() in the patch that was sent earlier.  A new patch 
> is attached.  I apologize for the goof.  Questions/comments?

Thanks, looks good.  Only concern is the duplication of the MLS
attribute handling code; we should use a common helper (although that
code should be obsoleted in the future anyway).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
