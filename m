Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA07765
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 14:57:48 -0400 (EDT)
Date: Tue, 1 Oct 2002 14:57:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200210011957.09306.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011443150.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Russell Coker wrote:

> I have attached a new patch that applies against the current CVS tree.  It
> adds some important things to the xauth support, particularly denying xdm_t
> write access to user_home_t.

Ok, merged.

> Steve, you may disagree with the xdm.te part, I think we've kept the alias for
> too long already...

Yes, that's fine.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
