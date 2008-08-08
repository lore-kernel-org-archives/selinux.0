Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78HA7WC014827
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 13:10:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m78H9wvJ018421
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 17:09:58 GMT
Message-ID: <489C7DEE.7090006@manicmethod.com>
Date: Fri, 08 Aug 2008 13:10:06 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>, Andy Warner <warner@rubix.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Request for multiple mailing lists
References: <489B25B6.4080309@windriver.com> <489C1BB1.2060701@rubix.com> <Pine.LNX.4.64L.0808081319150.25440@ruuvi.it.helsinki.fi> <200808082048.53795.russell@coker.com.au>
In-Reply-To: <200808082048.53795.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 08 August 2008 20:33, Vesa-Matti J Kari <vmkari@cc.helsinki.fi> 

<snip>

Back on topic:

I've multiple times in the past that I'd like to have a policy list that was separate. The main problem here is that all the core developers would almost certainly be subscribed to both (all) of them so there is little motivation on this end to split the lists out.

I completely disagree with splitting kernel and userland out as kernel changes almost always require userland changes, and userland changes are often created to address format changes, etc that are of interest to the kernel.

That said, even if we had to be subscribed to both it would be easier to disregard the parts less interesting to us (for me, that is policy, for Chris that is the other). 

So I'll +1 the request but believe only 2 lists are necessary.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
