Message-Id: <200504282033.j3SKWa8R030518@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Davide Bolcioni'" <dbolcioni@3di.it>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Subject: RE: Is there a SELinux tutorial for ISVs ?
Date: Thu, 28 Apr 2005 16:32:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <36282A1733C57546BE392885C06185928E2A19@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: fedora-selinux-list-bounces@redhat.com [mailto:fedora-selinux-list-
> bounces@redhat.com] On Behalf Of Chad Hanson
> Sent: Thursday, April 28, 2005 2:29 PM
> To: Daniel J Walsh; Davide Bolcioni
> Cc: SELinux; fedora-selinux-list@redhat.com
> Subject: RE: Is there a SELinux tutorial for ISVs ?
> 

<snip>

> > I see Tresys Stuff solving the problems of both of the above.
> >
> > 3 Local User customization and minor policies.  Currently we
> > have people
> 
> Along with local user policy, there needs to be local network policy
> customizations as well. This is required from an MLS perspective and I would
> think be useful for TE network restrictions as well.
> 

Definitely - users might want to only allow apache to serve pages to one netif
for example. Also, when the remaining network functionality is finished there
will be much more need to customize the network policy.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> http://www.redhat.com/mailman/listinfo/fedora-selinux-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
