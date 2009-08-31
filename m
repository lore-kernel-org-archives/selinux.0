Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VBgdk5021343
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 07:42:39 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7VBg1DZ013899
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 11:42:01 GMT
Date: Mon, 31 Aug 2009 21:42:33 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: David Miller <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] lsm: Add hooks to the TUN driver
In-Reply-To: <20090828.154636.192870325.davem@davemloft.net>
Message-ID: <alpine.LRH.2.00.0908312142070.19946@tundra.namei.org>
References: <20090828220400.3900.64377.stgit@flek.lan> <20090828221243.3900.15668.stgit@flek.lan> <20090828.154636.192870325.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Aug 2009, David Miller wrote:

> I'm happy if you guys merge this via the security tree,
> feel free to add:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks, I'll merge it via my tree.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
