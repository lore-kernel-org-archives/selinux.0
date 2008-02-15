Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FLf2dh006928
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 16:41:02 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FLewle022783
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 21:40:58 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 16:40:53 -0500
Cc: selinux@tycho.nsa.gov
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802151640.53368.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 February 2008 3:15:16 pm Clarkson, Mike R (US SSA) wrote:
> I'm running the server client example that Joshua Brindle provided in
> his article on labeled IPSec.

...

> The output of the client and server show that the labels are being
> sent over the loopback, but just to convince myself that the labeled
> IPSec loopback was indeed being used, I flushed the SPDs and SADs
> using "setkey -FP" and "setkey -F". Afterward, I get the following
> output, which is expected when labeled IPSec is not being used:
>
> [mr_clarkson@blade5 test]$ ./brindle_server
> getsockopt: Protocol not available
> server: got connection from 127.0.0.1, (null)
>
> [mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
> getpeercon: Protocol not available
> Received: Hello, (null) from (null)
>
> I need the missing association rules (shown above) to be able to
> apply MLS constraints on the connection between the client and
> server. Any suggestions on how to fix this would be greatly
> appreciated.

The problem is that you removed all of the IPsec labeling rules from the 
SPD when you ran 'setkey -FP'.  This means there is no IPsec processing 
taking place and hence no labeling.  You should be able to flush the 
SAD as racoon will repopulate it on the fly, but clearing the SPD 
removes the IPsec configuration from the kernel which is something you 
probably didn't intend to do.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
