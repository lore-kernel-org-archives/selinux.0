Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06149
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 07:11:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19651
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:09:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA19647
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:09:48 GMT
Date: Thu, 31 Oct 2002 07:11:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Greg KH <greg@kroah.com>
cc: <selinux@tycho.nsa.gov>, <linux-security-module@wirex.com>
Subject: Re: SELinux Kernel Oops
In-Reply-To: <20021030230034.GE3384@kroah.com>
Message-ID: <Pine.GSO.4.33.0210310706350.23380-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Greg KH wrote:

> Shouldn't you also fix SELinux to handle NULL security fields :)

And how you would suggest that we handle them?  The old precondition
approach was fundamentally flawed.  Failing closed (i.e. denying access)
when the field is NULL will break normal operation.  Failing open (i.e.
granting access) when the field is NULL opens a potential security
vulnerability.

> And wouldn't the proliferation of different fs types in 2.5 make this
> patch a bit bigger?

It doesn't appear that init_private_file is used much at present; I don't
know what the future plans are for it.  We covered every existing use in
the mainstream 2.4 and 2.5 kernels.  If an out-of-tree kernel patch
or module uses init_private_file, then we'll end up with an allocated
security field that is never freed, but I'd rather have a leak than an
Oops (and out-of-tree kernel patches and modules should naturally be
audited before using them with SELinux or any other security module).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
