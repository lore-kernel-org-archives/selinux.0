Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0UIEmRb020954
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 13:14:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0UIEc1K000799
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 18:14:42 GMT
Date: Fri, 30 Jan 2004 13:14:21 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Chris Wright <chrisw@osdl.org>
cc: linux-security-module@wirex.com, Stephen Smalley <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][RFC] Security mount data & sb_copy_data hook.
In-Reply-To: <20040130100208.A28565@osdlab.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0401301312070.16488-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 30 Jan 2004, Chris Wright wrote:

> > Any feedback on this will be most appreciated.
> 
> Hrm, I'm not really fond of the extra page, and extra hook.
> Unfortunately, it doesn't seem like doing something generic in
> lib/parser.c is feasible since not each fs uses it, and touching each
> fs to find this is even uglier.

The extra page isn't really an issue as mounting a fileystem is not 
performance critical.

>  Would it be possible to handle it all
> in the module with something like:
> 
> mount -tselinux -oreal_type=$fstype,context=foo,the_fs_opts dev mntpnt

I'm not sure how this could be done cleanly without further reaching into 
the vfs (e.g. to hijack the real filesystem ops etc.).  Perhaps better 
when we have a proper filesystem stacking mechanism available.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
