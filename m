Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SIihrT009799
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 14:44:43 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SIheuK002288
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:43:41 GMT
Subject: Re: policy patches needed for Fedora
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200409240337.03210.russell@coker.com.au>
References: <200409240337.03210.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096397022.30810.89.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 14:43:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan had already picked up everything except the hostname stuff in his
Sep 27th patch.  I merged the hostname part.

On Thu, 2004-09-23 at 13:37, Russell Coker wrote:
> The attached patch allows domains that run before a tmpfs /dev is labelled 
> correctly to access tmpfs_t:chr_file and tmpfs_t:dir for Fedora.
> 
> For all systems I allow initrc_t to access usbfs_t.  It's necessary right now 
> on Fedora and probably will be on other systems in the near future.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
