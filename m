Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91H58IV016304
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 13:05:08 -0400
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91H43YT012874
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 17:04:04 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 15/16] cipso: Add support for native local labeling and fixup mapping names
Date: Wed, 1 Oct 2008 13:05:04 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125730.17132.74360.stgit@flek.lan> <alpine.LRH.1.10.0810012003170.6732@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810012003170.6732@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011305.04872.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2008 6:09:30 am James Morris wrote:
> On Tue, 16 Sep 2008, Paul Moore wrote:
> > +/* Base length of the local tag (non-standard tag).
> > + *  Tag definition (may change between kernel versions)
> > + *
> > + * 0          8          16         24         32
> > + * +----------+----------+----------+----------+
> > + * | 10000000 | 00001000 | unused (zero fill)  |
> > + * +----------+----------+----------+----------+
> > + * |   32-bit secid value (host byte order)    |
> > + * +----------+----------+----------+----------+
> > + *
> > + */
> > +#define CIPSO_V4_TAG_LOC_BLEN         8
> > +
> >
> > +static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
> > +			       const struct netlbl_lsm_secattr *secattr,
> > +			       unsigned char *buffer,
> > +			       u32 buffer_len)
> > +{
> > +	if (!(secattr->flags & NETLBL_SECATTR_SECID))
> > +		return -EPERM;
> > +
> > +	buffer[0] = 0x80;
> > +	buffer[1] = 0x08;
> > +	*(u32 *)&buffer[4] = secattr->attr.secid;
> > +
> > +	return 8;
> > +}
>
> Macros would be nice for these ...

I assume you mean the "0x80" and "0x08" constants and not the function 
itself?  I ask because I remember reading that (macros == evil) because 
of the lack of parameter type checking.

> ... and why specify zero filling?  (Setting and testing that would be
> wasted cycles, if you enforced it). 

Better alignment within the IP option field, the goal being to try and 
get the secid aligned on a 32bit boundary.  However, it just occurred 
to me that by adding the two octets of padding I've actually pushed it 
out of alignment (I forgot about the obligatory IP option type and 
length octets).

Man I hate IPv4 options, what a parsing nightmare ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
