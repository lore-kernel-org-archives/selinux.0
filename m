Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i47FM8Rb002891
	for <selinux@tycho.nsa.gov>; Fri, 7 May 2004 11:22:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i47FJo5b022318
	for <selinux@tycho.nsa.gov>; Fri, 7 May 2004 15:19:51 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i47FJoql022315
	for <selinux@tycho.nsa.gov>; Fri, 7 May 2004 15:19:50 GMT
Date: Fri, 7 May 2004 11:21:52 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
   <netdev@oss.sgi.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 2/2 sock_create_lite()
In-Reply-To: <20040507161455.A31114@infradead.org>
Message-ID: <Xine.LNX.4.44.0405071118490.21529-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 May 2004, Christoph Hellwig wrote:

> On Fri, May 07, 2004 at 11:06:04AM -0400, James Morris wrote:
> > This patch adds a function sock_create_lite(), deprecating kernel-wide use
> > of sock_alloc(), which has been made static to net/socket.c.
> 
> We're in the stable series and removing exported APIs there shoudn't happen.
> Given that sock_alloc() is actually okay for every normal use I don't think
> there's enough reason to remove it from the API.

Fair enough.

> > +int sock_create_lite(int family, int type, int protocol, struct socket **res)
> 
> Should probably be called __sock_create according to linux naming rules.
> Also I guess you should actually call it from sock_create instead of
> duplicating the code.

sock_create() is really very different to sock_alloc(), and the only real
duplication is calling the LSM hooks.  The version I sent seems to be the
simplest approach.

(note that __sock_create() is already created in the previous patch).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
