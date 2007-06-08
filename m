Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l581KNNo021057
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 21:20:23 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l581KM6F016568
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 01:20:22 GMT
Date: Thu, 7 Jun 2007 21:20:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] fix several unaligned kernel accesses in the CIPSO
 engine
In-Reply-To: <20070607153610.888828690@hp.com>
Message-ID: <Line.LNX.4.64.0706072120050.10435@d.namei>
References: <20070607153226.524778346@hp.com> <20070607153610.888828690@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Jun 2007, Paul Moore wrote:

> IPv4 options are not very well aligned within the packet and the format of a
> CIPSO option is even worse.  The result is that the CIPSO engine in the kernel
> does a few unaligned accesses when parsing and validating incoming packets with
> CIPSO options attached which generate error messages on certain alignment
> sensitive platforms.  This patch fixes this by marking these unaligned accesses
> with the get_unaliagned() macro.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>


Acked-by: James Morris <jmorris@namei.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
