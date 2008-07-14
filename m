Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EGlD3j003361
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:47:13 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EGlCiV025294
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:47:13 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6EGkpBq024086
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:46:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ping and the /tmp directory
Date: Mon, 14 Jul 2008 09:46:54 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70F010A9C2F@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net> <653FACE3-C619-4DD2-8DD0-137333A7B3BE@nall.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Joe Nall" <joe@nall.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No

> -----Original Message-----
> From: Joe Nall [mailto:joe@nall.com]
> Sent: Monday, July 14, 2008 9:43 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: ping and the /tmp directory
> 
> 
> On Jul 14, 2008, at 11:10 AM, Clarkson, Mike R (US SSA) wrote:
> 
> > Does the ping utility normally read/write to the /tmp directory?
> >
> > I've got a domain that uses ping in the ping_t domain, using the
> > netutils_domtrans_ping interface, and I'm getting the following from
> > audit2allow:
> >
> > allow ping_t tmp_t:file { read write getattr ioctl };
> 
> Is stdout of the parent process being redirected to a tmp file?
> 
> joe
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
