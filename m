Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1INlcRb025814
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 18:47:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1INk5lM013715
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 23:46:07 GMT
Date: Wed, 18 Feb 2004 18:47:33 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Chris Wright <chrisw@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, <akpm@osdl.org>,
   <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>
Subject: Re: [SELINUX] Event notifications via Netlink
In-Reply-To: <20040218144346.B22989@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Feb 2004, Chris Wright wrote:

> * James Morris (jmorris@redhat.com) wrote:
> > +static int selnl_msglen(int msgtype)
> > +	default:
> > +		BUG();
> > +static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *data)
> > +	default:
> > +		BUG();
> 
> Is BUG() the best error here, or too draconian?
> 

Reaching this would be incorrect use of a kernel API, leading to 
malfunctioning security code, so I feel that a BUG() is appropriate.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
