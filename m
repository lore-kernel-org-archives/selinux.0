Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89KX8rT014749
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:33:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89KWFo3003031
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 20:32:15 GMT
Subject: Re: dev_filesystem policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409090500.31105.russell@coker.com.au>
References: <200409090500.31105.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1094761938.2895.62.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 16:32:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.
Though after consulting with Steve, went with the attribute name dev_fs.

On Wed, 2004-09-08 at 15:00, Russell Coker wrote:
> To use tmpfs for /dev we need to allow all device types to associate with the 
> tmpfs.  To make this easier I have attached a patch to give all types that 
> may be used for objects under /tmp the attribute dev_filesystem.
> 
> I am still working on getting the tmpfs to work correctly, but this is a 
> necessary first step.
> 
> 
> Steve, if you don't like the name dev_filesystem then please feel free to 
> change it.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
