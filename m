Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA15098
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 15:57:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA05781
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 20:55:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA05775
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 20:55:40 GMT
Date: Mon, 28 Oct 2002 15:56:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: run_init
In-Reply-To: <200210260338.39715.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210281537590.29887-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 26 Oct 2002, Russell Coker wrote:

> I have attached the policy patch to this message.  Steve, I encourage you to
> apply this patch to the CVS now.  It does what you want the policy to do.  We
> can probably have a discussion about the best way of implementing the
> openpty() code (and my code at the moment is a bit messy).  But regardless of
> how we might decide to change it, it'll at most require something like a 2
> line policy patch.
>
> Also the policy patch applies on top of my previous patch.

I've merged the policy patch but I have not yet merged the modified
run_init program (no harm caused by the policy changes) pending further
review.  It might be preferable to not change SIDs until you execute the
init script from open_init_pty (i.e. run_init does a normal exec of
open_init_pty or open_init_pty is directly folded into run_init), and have
the pty labeled run_init_devpts_t.  That would make it clearer that you
are only granting the daemons the ability to access a pty created by
run_init, not any arbitrary pty that happens to be created by an initrc_t
process.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
