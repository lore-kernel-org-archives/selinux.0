Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6MQuSf020676
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 17:26:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA6MQW1W010652
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 22:26:32 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id hA6MQW5e010649
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 22:26:32 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6MQsh9032645
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 17:26:54 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hA6MQsfk032643
	for selinux@tycho.nsa.gov; Thu, 6 Nov 2003 17:26:54 -0500
Date: Thu, 6 Nov 2003 17:15:11 -0500 (EST)
From: Dean Anderson <dean@av8.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Bill Laut <wlsel@verizon.net>, <SELinux@tycho.nsa.gov>
Subject: Re: Verify the integrity of downloaded archives
In-Reply-To: <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0311061655460.32156-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, you don't have to break into the NSA to alter the NSA downloads. All
you need is an ISP in the middle.  More to the point, when the distro is
mirrored, the mirror and the download path is vulnerable.

Key trust is a matter of time.  I see the Stephen's point of view, but I
think the NSA must think that information usually depreciates. In the case
of a public key, it appreciates. A key that was obtained good last month,
appeared valid last month, and hasn't been reported compromised in the
meantime is probably more trustworthy than a certificate just obtained at
the same time as the download which it will be used to check.  So that is
how I base trust in the key used to sign the distributions.  The value
cycle of a key is like that of a boat: It appreciates for a time, and then
expires, and the value collapses.

The NSA does not need to obtain a certificate from Verisign** or some
other CA in order to have trusted public keys.  It just needs to be able
to distribute them widely, so that they can appreciate in value.


** No doubt it would be totally upsidedown to the NSA to have Verisign or
some other company vouch for the NSA.  How ridiculous.  That is like
having a private certify the orders of a general.  Although, as I write
this, I wonder what Cert's the NSA uses on its secure web sites...  I
would think that the NSA would have its own Certificate Authority, as its
mission is to provide communications security for government
organizations, some of which must have their own secure web pages.  If it
has a CA, and the CA certificate is commercially distributed, then getting
a cert to sign the distro should be a matter of internal paperwork, No?

		--Dean

On 6 Nov 2003, Stephen Smalley wrote:

> On Thu, 2003-11-06 at 01:11, Bill Laut wrote:
> > While I'd love to meet a hacker who could successfully break into the NSA's
> > website to install a Trojan (;-), Oliver does bring up a good point.  As
> > SELinux gains a wider audience it would be reasonable to anticipate the
> > distro eventually getting mirrored at other sites.  Since the use of digital
> > signatures as an integrity-check is now commonplace within the Linux
> > community, would it be reasonable to start posting signatures on the NSA
> > website?
>
> Possibly.  Since we originally released SELinux as a proof of concept /
> reference implementation and it has never been intended to be a Linux
> distribution unto itself (although it can be incorporated into one),
> this hasn't been a major concern in the past.  However, I understand the
> concern.  On the other hand, on what basis would you trust the key used
> to sign the archives and patches?
>
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
