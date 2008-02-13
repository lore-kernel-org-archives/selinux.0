Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1DI4Mqc026441
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 13:04:22 -0500
Received: from g5t0008.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1DI3gNg010020
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 18:04:07 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: CORBA and network labeling capabilities
Date: Wed, 13 Feb 2008 08:47:20 -0500
Cc: selinux@tycho.nsa.gov
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802130847.21044.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 February 2008 7:50:31 pm Clarkson, Mike R (US SSA) wrote:
> The problem results from the fact that there are no rules associating
> any of the 3 domains with each other. This means that if I have multiple
> clients and servers, I can't set up rules to specify which clients can
> communicate with which servers. I'm stuck with every client being able
> to communicate with every server. (Actually, I could limit communication
> by running the clients and servers on specified labeled ports, but this
> eliminates any practical method of enforcing MLS constraints)
>
> If the client and server were running on separate hosts, with an IPSec
> tunnel set up between them, the functionality that I'm looking for is
> provided with the IPSec security association object class:
>
> allow sample_client_orbix_client_server_t
> sample_server_orbix_client_server_t:association recvfrom;
>
> Is there some way to get similar functionality when the processes are
> running on the same host? (Can an IPSec tunnel can be created through
> the loopback interface? Or is there a better way to do this?)

Hi Mike,

If you can live with only MLS label information you can use NetLabel/CIPSO to 
convey security attributes over the network, including localhost/loopback.  
The problem is that the standard CIPSO protocol doesn't have a way to convey 
the SELinux type enforcement information so only the effective MLS 
sensitivity label can be transferred over the network.  Labeled IPsec does 
work over localhost/loopback but as you can imagine it is not an elegant 
solution.  Which method you chose largely depends on your requirements, 
typically the need for full TE information and performance.

Once things settle down a bit with 2.6.25 and the labeled networking changes 
that were just merged I plan on starting work on improved local labeling 
which would provide some better options than those listed above.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
