Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATL1LNX000743
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 16:01:21 -0500
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATKxc46008049
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 20:59:38 GMT
Date: Wed, 29 Nov 2006 16:01:41 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] NetLabel: add the ranged tag to the CIPSOv4 protocol
In-Reply-To: <20061129182854.816890000@hp.com>
Message-ID: <XMMS.LNX.4.64.0611291600250.24178@d.namei>
References: <20061129181817.505281000@hp.com> <20061129182854.816890000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Nov 2006, paul.moore@hp.com wrote:

> +{
> +	/* The constant '16' is not random, it is the maximum number of
> +	 * high/low category range pairs as permitted by the CIPSO draft based
> +	 * on a maximum IPv4 header length of 60 bytes - the BUG_ON() assertion
> +	 * does a sanity check to make sure we don't overflow the array. */
> +	int iter = -1;
> +	u16 array[16];

Perhaps in a future update, make this a value a macro definition and 
document it in the header.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
