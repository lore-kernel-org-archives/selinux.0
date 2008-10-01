Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91A9Vae022509
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 06:09:31 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91A8QHK005571
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 10:08:27 GMT
Date: Wed, 1 Oct 2008 20:09:30 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 15/16] cipso: Add support for native local labeling
 and fixup mapping names
In-Reply-To: <20080916125730.17132.74360.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810012003170.6732@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125730.17132.74360.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> +/* Base length of the local tag (non-standard tag).
> + *  Tag definition (may change between kernel versions)
> + *
> + * 0          8          16         24         32
> + * +----------+----------+----------+----------+
> + * | 10000000 | 00001000 | unused (zero fill)  |
> + * +----------+----------+----------+----------+
> + * |   32-bit secid value (host byte order)    |
> + * +----------+----------+----------+----------+
> + *
> + */
> +#define CIPSO_V4_TAG_LOC_BLEN         8
> +

> +static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
> +			       const struct netlbl_lsm_secattr *secattr,
> +			       unsigned char *buffer,
> +			       u32 buffer_len)
> +{
> +	if (!(secattr->flags & NETLBL_SECATTR_SECID))
> +		return -EPERM;
> +
> +	buffer[0] = 0x80;
> +	buffer[1] = 0x08;
> +	*(u32 *)&buffer[4] = secattr->attr.secid;
> +
> +	return 8;
> +}

Macros would be nice for these, and why specify zero filling?  (Setting 
and testing that would be wasted cycles, if you enforced it).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
