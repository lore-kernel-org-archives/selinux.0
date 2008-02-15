Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FNll1K021360
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:47:47 -0500
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FNlkle002977
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 23:47:46 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1FNlJa9003317
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:47:19 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m1FNlEib020512
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:47:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 15:47:45 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF974E@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net> <200802151640.53368.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net> <200802151842.53403.paul.moore@hp.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Friday, February 15, 2008 3:43 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Brindle example of labeled IPSec
> 
> On Friday 15 February 2008 6:25:45 pm Clarkson, Mike R (US SSA) wrote:
> > I understand why there is no labeling after doing "setkey -FP". That
> > was expected.
> 
> I'm sorry, I mis-read your original question.
> 
> > My question is why does the labeling work in enforcing mode, even
> > though my policy does not provide the following rules:
> > allow brindle_client_t ipsec_spd_t:association polmatch;
> > allow brindle_client_t brindle_server_t:association recvfrom;
> >
> > With labeled IPSec over the loopback, I did not have to provide any
> > rules in my brindle_client module or my brindle_server module with
> > respect to the association object class. Without the association
> > rules, the policy doesn't have any way of enforcing MLS constraints,
> > or TE on the client server connections, which is the reason that I
> > set up labeled IPSec over loopback in the first place.
> 
> That is interesting isn't it?  I don't have an answer off the top of
my
> head which means I need to go and dig through the kernel and policy to
> try and piece together what is going on.  What kernel version and
> policy version are you running?

Kernel: 2.6.18-53.el5 (x86_64)
Policy: RHEL5.1

Thanks

> 
> --
> paul moore
> linux security @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
