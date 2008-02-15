Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FNgxsx020987
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:42:59 -0500
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FNgxAb023553
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 23:42:59 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 18:42:53 -0500
Cc: selinux@tycho.nsa.gov
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net> <200802151640.53368.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802151842.53403.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 February 2008 6:25:45 pm Clarkson, Mike R (US SSA) wrote:
> I understand why there is no labeling after doing "setkey -FP". That
> was expected.

I'm sorry, I mis-read your original question.

> My question is why does the labeling work in enforcing mode, even
> though my policy does not provide the following rules:
> allow brindle_client_t ipsec_spd_t:association polmatch;
> allow brindle_client_t brindle_server_t:association recvfrom;
>
> With labeled IPSec over the loopback, I did not have to provide any
> rules in my brindle_client module or my brindle_server module with
> respect to the association object class. Without the association
> rules, the policy doesn't have any way of enforcing MLS constraints,
> or TE on the client server connections, which is the reason that I
> set up labeled IPSec over loopback in the first place.

That is interesting isn't it?  I don't have an answer off the top of my 
head which means I need to go and dig through the kernel and policy to 
try and piece together what is going on.  What kernel version and 
policy version are you running?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
