Date: Wed, 27 Mar 2002 08:55:42 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: R2-Q2 <r2q2@rocketmail.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Fractal Based Encryption
In-Reply-To: <20020327122518.700D4300@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203270852180.8022-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Mar 2002, Russell Coker wrote:

> Why would encryption need to be integrated into SE Linux?
>
> Sure people who want SE Linux want encryption.  But why do they need to be
> directly connected?

They don't have to be directly connected (e.g. you can use FreeSWAN IPSEC
orthogonally with SELinux), but there are some reasons to consider tighter
integration.  See Pete's earlier email on this topic at
http://marc.theaimsgroup.com/?l=selinux&m=98175653726530&w=2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
