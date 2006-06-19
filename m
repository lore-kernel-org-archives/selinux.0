Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5JEmmvJ011911
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 10:48:48 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5JEmkxZ022638
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 14:48:46 GMT
Date: Mon, 19 Jun 2006 10:48:44 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com, sds@tycho.nsa.gov
Subject: Re: [PATCH] new sockcreate interface to specify context of socket
 when they are created
In-Reply-To: <1150493312.19704.73.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606191046150.21114@d.namei>
References: <1150493312.19704.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jun 2006, Eric Paris wrote:

Looks fine, just a couple of minor issues.

> +	newsid = tsec->sockcreate_sid;
> +	if(!newsid)

Kernel coding style is:

	if (!newsid)

> +	newsid = tsec->sockcreate_sid;
> +	if(!newsid)
> +		newsid = tsec->sid;

What about:
	newsid = tsec->sockcreate_sid ? : tsec->sid;




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
