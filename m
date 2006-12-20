Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBKEpIRD015144
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 09:51:19 -0500
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBKEprHx005043
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 14:51:54 GMT
Date: Wed, 20 Dec 2006 09:51:48 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: "Nerazzurri.YANG" <spng.yang@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: please guide me a way to study selinux in Kernel
In-Reply-To: <4588DF97.3060703@gmail.com>
Message-ID: <XMMS.LNX.4.64.0612200948250.2110@d.namei>
References: <200612150142.kBF1gsHi002790@faith.austin.ibm.com>
 <4588DF97.3060703@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Dec 2006, Nerazzurri.YANG wrote:

> but i can not find more informations about that, except
> the docs in NSA website.

Here are some slides I made for a talk last year at Foss.in:
http://people.redhat.com/jmorris/slides/fossin2005_selinux_kernel.pdf

SELinux uses LSM, so also see:
http://www.usenix.org/event/sec02/wright.html



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
