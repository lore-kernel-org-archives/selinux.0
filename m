Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GHfrrT026827
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 13:41:54 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GHev8m001833
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 17:40:57 GMT
Subject: Re: hald fix
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
References: <200409162151.44819.russell@coker.com.au>
	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1095356454.17251.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 13:40:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since all of the helpers executed by hald haven't been identified, I've
reverted back to the can_exec_any() for now.

On Thu, 2004-09-16 at 10:52, James Carter wrote:
> Thanks.  In CVS now.
> 
> On Thu, 2004-09-16 at 07:51, Russell Coker wrote:
> > The attached patch fixes a typo to make hald work with dbus and removes an 
> > unnecessary can_exec_any().
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
