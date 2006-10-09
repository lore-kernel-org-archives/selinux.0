Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99KJVvm026980
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 16:19:31 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99KIr1s008920
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 20:18:53 GMT
Date: Mon, 9 Oct 2006 16:19:29 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>, "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 00/11] The _entire_ secid reconciliation patchset (tada!)
In-Reply-To: <20061009194223.402695000@hp.com>
Message-ID: <Pine.LNX.4.64.0610091612140.31187@d.namei>
References: <20061009194223.402695000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Oct 2006, paul.moore@hp.com wrote:

> Please consider this for inclusion into 2.6.20.  If it's too soon to be
> thinking of 2.6.20 let me know and I'll rebase/resend this patchset once I see
> notice of David's net-2.6.20 git tree.

>From an initial review of this patchset, it doesn't look quite ready to 
queue for 2.6.20 (which I plan to to via git once it is).

Outstanding items include resolving the igmp skb hook issue generally, 
testing to verify both the design and implementation, and ensuring that 
all the related policy changes are merged upstream first.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
