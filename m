Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20618
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:10:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27541
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:08:22 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA27537 for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:08:21 GMT
Date: Tue, 29 Oct 2002 12:09:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: New Apache policy
In-Reply-To: <20021029173606.A28387@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210291146020.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Oct 2002, Tom wrote:

> The main reason for giving the client tools a domain was to unify
> server and client access, i.e. set up the repository so that it can
> only be accessed by the proper tools. As with CVS, tampering directly
> with the repository will corrupt it.

It would offer some limited integrity protection in terms of ensuring that
the transactions on the repository are well-formed (i.e. only permitting
transactions implemented via svn, svnlock, or svnadmin commands).  But it
doesn't prevent the user domain from wreaking havoc on the repository
using these client programs, unless the programs implement their own
access controls.

> Also, this leaves the option of restricting access to the repository by
> restricting access to the tools by using either unix or SELinux
> permissions.

With a client program domain, this would take the form of only specifying
svn_domain() for certain user domains as opposed to all of them.  Without
a client program domain, it would simply consist of only allowing certain
user domains to directly access the repository type.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
