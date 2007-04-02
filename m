Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32GGcD7012059
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 12:16:41 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32GGZss003562
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 16:16:36 GMT
Date: Mon, 2 Apr 2007 12:16:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: secmark integration
In-Reply-To: <1175525718.20396.46.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0704021215020.8213@d.namei>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
 <1175284031.3602.24.camel@localhost.localdomain>
 <1175286309.20396.13.camel@localhost.localdomain>  <Line.LNX.4.64.0703302201520.29742@d.namei>
  <46111709.9060402@redhat.com> <1175525718.20396.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Apr 2007, Eric Paris wrote:

> Seems to me that port number is the only thing we can label based on for
> everyone out of the box.  Any more complex labeling scheme is going to
> require network specific information, right?

For gateways & externally facing systems, we could use types for the 
interfaces, e.g. external_netif, internal_netif and have a loadable module 
or something which differentiates between internal and external traffic.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
