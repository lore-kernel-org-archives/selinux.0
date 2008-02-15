Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FNPqQa019417
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:25:52 -0500
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FNPple026223
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 23:25:51 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1FNPOvP006061
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:25:24 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1FNPLMO024031
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:25:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 15:25:45 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net> <200802151640.53368.paul.moore@hp.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

I didn't make my original question clear enough. Please see comments
below.

Thanks,
  Mike

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Friday, February 15, 2008 1:41 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Brindle example of labeled IPSec
> 
> On Friday 15 February 2008 3:15:16 pm Clarkson, Mike R (US SSA) wrote:
> > I'm running the server client example that Joshua Brindle provided
in
> > his article on labeled IPSec.
> 
> ...
> 
> > The output of the client and server show that the labels are being
> > sent over the loopback, but just to convince myself that the labeled
> > IPSec loopback was indeed being used, I flushed the SPDs and SADs
> > using "setkey -FP" and "setkey -F". Afterward, I get the following
> > output, which is expected when labeled IPSec is not being used:
> >
> > [mr_clarkson@blade5 test]$ ./brindle_server
> > getsockopt: Protocol not available
> > server: got connection from 127.0.0.1, (null)
> >
> > [mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
> > getpeercon: Protocol not available
> > Received: Hello, (null) from (null)
> >
> > I need the missing association rules (shown above) to be able to
> > apply MLS constraints on the connection between the client and
> > server. Any suggestions on how to fix this would be greatly
> > appreciated.
> 
> The problem is that you removed all of the IPsec labeling rules from
the
> SPD when you ran 'setkey -FP'.  This means there is no IPsec
processing
> taking place and hence no labeling.  You should be able to flush the
> SAD as racoon will repopulate it on the fly, but clearing the SPD
> removes the IPsec configuration from the kernel which is something you
> probably didn't intend to do.
> 

I understand why there is no labeling after doing "setkey -FP". That was
expected.

My question is why does the labeling work in enforcing mode, even though
my policy does not provide the following rules:
allow brindle_client_t ipsec_spd_t:association polmatch;
allow brindle_client_t brindle_server_t:association recvfrom;

With labeled IPSec over the loopback, I did not have to provide any
rules in my brindle_client module or my brindle_server module with
respect to the association object class. Without the association rules,
the policy doesn't have any way of enforcing MLS constraints, or TE on
the client server connections, which is the reason that I set up labeled
IPSec over loopback in the first place.

Any help would be much appreciated,
  Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
