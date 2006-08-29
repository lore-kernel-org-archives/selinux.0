Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TGwWhg023166
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 12:58:32 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TGwCx8002772
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 16:58:13 GMT
Date: Tue, 29 Aug 2006 12:58:27 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Andrew Morton <akpm@osdl.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4/6] NetLabel: cleanup ebitmap_import()
In-Reply-To: <20060829144446.324001000@hp.com>
Message-ID: <Pine.LNX.4.64.0608291258180.29142@d.namei>
References: <20060829144251.452774000@hp.com> <20060829144446.324001000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Aug 2006, paul.moore@hp.com wrote:

> Rewrite ebitmap_import() so it is a bit cleaner and easier to read.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
