Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GErOrT025439
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 10:53:24 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GEqN8m019430
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 14:52:28 GMT
Subject: Re: hald fix
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409162151.44819.russell@coker.com.au>
References: <200409162151.44819.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 10:52:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  In CVS now.

On Thu, 2004-09-16 at 07:51, Russell Coker wrote:
> The attached patch fixes a typo to make hald work with dbus and removes an 
> unnecessary can_exec_any().
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
