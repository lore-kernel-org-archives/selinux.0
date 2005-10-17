Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HKs2Ns003187
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 16:54:02 -0400 (EDT)
Received: from mail25.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9HKpDSN026861
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 20:51:14 GMT
Date: Mon, 17 Oct 2005 16:51:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC] Dynamic discover of object classes
In-Reply-To: <200510171328.30452.csellers@tresys.com>
Message-ID: <Pine.LNX.4.63.0510171649190.24028@excalibur.intercode>
References: <200510171328.30452.csellers@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Oct 2005, Chad Sellers wrote:

> We would like to begin implementing option 1, as this seems to be the 
> cleanest.  Any feedback would be appreciated.

selinuxfs sounds cleaner.  There's no guarantee that there will be a 
binary policy on disk.

Also, what about some form of namespace separation for different object 
managers?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
