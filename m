Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G3fJrT000281
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 23:41:19 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G3fARI022477
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 03:41:10 GMT
Date: Tue, 15 Jun 2004 23:40:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
   <linux-kernel@vger.kernel.org>, <selinux@tycho.nsa.gov>
Subject: Re: [SELINUX][PATCH 1/4] Fine-grained Netlink support - SELinux
 headers update
In-Reply-To: <40CFBD04.8030601@pobox.com>
Message-ID: <Xine.LNX.4.44.0406152334380.30782-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Jun 2004, Jeff Garzik wrote:

> James Morris wrote:
> > This patch regenerates the SELinux module headers to reflect new class
> > and access vectors definitions.  The size of the diff is misleading;
> > much of it is simply a change in the ordering of the automatically
> > generated definitions. The corresponding generation script has been
> > changed to ensure a stable order in the future.  Please apply.
> 
> 
> Why not commit the generation script, and kill the auto-generated files?

The script lives in the SELinux policy compilation package, which is
considered the source of truth for these headers.  They are only ever
regenerated manually when significant changes are made to SELinux (like
this), and I don't think there is any advantage in doing this in the
kernel tree.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
