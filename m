Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55L0uYJ024715
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 17:00:56 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l55L0sRI014753
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 21:00:55 GMT
Date: Tue, 5 Jun 2007 17:00:51 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Alan Cox <alan@redhat.com>, drepper@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        chrisw@redhat.com, sds@tycho.nsa.gov, sgrubb@redhat.com
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
In-Reply-To: <1181075666.3978.31.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0706051658170.23379@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
 <20070603205653.GE25869@devserv.devel.redhat.com>
 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
 <1181075666.3978.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 5 Jun 2007, Eric Paris wrote:

> +extern int mmap_protect_memory;

This should be an unsigned long.

I wonder if the default should be for this value to be zero (i.e. preserve 
existing behavior).  It could break binaries, albeit potentially insecure 
ones.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
