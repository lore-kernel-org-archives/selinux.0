Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1E40S0Z029899
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 23:00:28 -0500
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1E40S6g013850
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 04:00:28 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: CORBA and network labeling capabilities
Date: Wed, 13 Feb 2008 23:00:23 -0500
Cc: selinux@tycho.nsa.gov
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net> <200802131632.05679.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF95E6@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF95E6@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802132300.23563.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 13 February 2008 8:45:50 pm Clarkson, Mike R (US SSA) wrote:
> Paul,
>
> Thanks for your help. I've got labeled IPSec working on the loopback
> interface. I've still got some policy work to do to get everything
> working like I want, but the labeled IPSec portion appears to be
> working.
>
> The key was enabling XFRM as you mentioned below and updating my setkey
> commands as follows:
>
> spdflush;
> flush;
> spdadd 127.0.0.1 127.0.0.1 any
> -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
> -P in ipsec esp/transport//require;
> spdadd 127.0.0.1 127.0.0.1 any
> -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
> -P out ipsec esp/transport//require;
>
> The key differences are using 127.0.0.1 for both the src and dest
> addresses, and using "any" for the upperspec.

Glad to hear you got everything working.  I forgot to mention this earlier, 
but in case you haven't seen it already Joshua Brindle wrote up a nice 
article on labeled IPsec which might help you with some of the policy pieces.

 * http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux

Good luck and let us know if you run into any problems.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
