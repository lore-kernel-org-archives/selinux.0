Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6LH7RYs004067
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 13:07:27 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6LH8GK6029166
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 17:08:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n6LH6YH6021502
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 13:06:34 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n6LH6Yxk021500
	for selinux@tycho.nsa.gov; Tue, 21 Jul 2009 13:06:34 -0400
Subject: Re: [PATCH 1/2] VM/SELinux: require CAP_SYS_RAWIO for all
 mmap_zero operations
From: Eric Paris <eparis@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
        jmorris@namei.org, spender@grsecurity.net, dwalsh@redhat.com,
        cl@linux-foundation.org, arjan@infradead.org, kyle@mcmartin.ca,
        cpardy@redhat.com, arnd@arndb.de
In-Reply-To: <20090721170909.6182230c@lxorguk.ukuu.org.uk>
References: <20090721144157.14159.23439.stgit@paris.rdu.redhat.com>
	 <20090721160437.5bda68b4@lxorguk.ukuu.org.uk>
	 <1248189524.2654.301.camel@localhost>
	 <20090721163813.0cb5d7ab@lxorguk.ukuu.org.uk>
	 <1248191833.2654.320.camel@localhost>
	 <20090721170909.6182230c@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 12:23:14 -0400
Message-Id: <1248193394.2654.327.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-21 at 17:09 +0100, Alan Cox wrote:

> It's a really ugly problem that almost begs for better hardware
> facilities (such as the multiple independent address spaces in some
> processors)

If only we knew someone who worked at intel.....   *smile*

Are you on board with the change I propose as long as I make the address
space controlled by SELinux tunable instead of fixed at one page?  Thus
allowing one to maintain the status quo?  Yeah, still sucks for
non-selinux systems and wine, but at least there can be hardening
against a non-root local authenticated user on a default fedora
install...

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
