Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05963
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:54:37 -0400 (EDT)
Date: Tue, 1 Oct 2002 12:53:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: rlogin policy patch
In-Reply-To: <200210011158.04480.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011253230.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Russell Coker wrote:

> I've attached a patch for the Debian telnetd setup.  In Debian telnetd runs a
> SUID root wrapper for calling /bin/login so that telnetd can be run as
> non-root.
>
> For running with SE Linux it's easiest to just run telnetd as root (to deny
> inetd setuid capability) but it still calls the wrapper by default anyway.
>
> This patch allows that use, and doesn't give any significant extra access, so
> I think it is worthy of inclusion in the CVS.

Thanks, merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
