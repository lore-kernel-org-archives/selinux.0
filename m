Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k724JcDI014908
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 00:19:38 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k724JWeA024050
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 04:19:32 GMT
Date: Wed, 2 Aug 2006 00:19:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [RFC 1/3] secid reconciliation on inbound
In-Reply-To: <Pine.LNX.4.64.0608011912130.14724@d.namei>
Message-ID: <Pine.LNX.4.64.0608020018410.16774@d.namei>
References: <44CFD0DA.9060205@trustedcs.com> <Pine.LNX.4.64.0608011912130.14724@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Aug 2006, James Morris wrote:

> On Tue, 1 Aug 2006, Venkat Yekkirala wrote:
> 
> > +#define PACKET__COME_THRU                         0x00000008UL
> > +#define PACKET__GO_THRU                           0x00000010UL
> 
> These names seem awkward, and do we really need a separate perm for each 
> direction?

Ok, I see we need separate permissions.  The naming, still...


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
