Date: Thu, 20 Jun 2002 11:07:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?us-ascii?Q?Vanuxem_gregory?= <gvanuxem@club-internet.fr>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: TR: MLS changes (isn't understandable)
In-Reply-To: <ADEEIKPBIEHIINPOFGAOIEHOCDAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0206201058080.16259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 17 Jun 2002, Vanuxem gregory wrote:

> What do you think about that and where I can find some documentation (doc
> not previously mentioned in this mailing list) and code source (better)
> about polyinstantiated object ?

I think that the Flask paper is the best available description of
polyinstantiated objects, but it is a high level description.
There was some experimental code in the original SELinux kernel patch
(still available from the NSA SELinux web site) for a
primitive form of polyinstantiated directories.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
