Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TH1OSJ023331
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 13:01:24 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TH15x8003095
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 17:01:06 GMT
Date: Tue, 29 Aug 2006 13:01:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Andrew Morton <akpm@osdl.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/6] NetLabel: correctly initialize the NetLabel fields
In-Reply-To: <20060829144444.202106000@hp.com>
Message-ID: <Pine.LNX.4.64.0608291259490.29142@d.namei>
References: <20060829144251.452774000@hp.com> <20060829144444.202106000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Aug 2006, paul.moore@hp.com wrote:

> Fix a problem where the NetLabel specific fields of the sk_security_struct
> structure were not being initialized early enough in some cases.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Regardless of the mapped ipv6 socket issue, I think these should be 
applied as fixes in their own right.  The mapped ipv6 socket stuff can be 
done separately if required.


Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
