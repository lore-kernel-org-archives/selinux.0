Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA26792
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 08:58:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA28283
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 12:57:28 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA28279 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 12:57:27 GMT
Date: Mon, 29 Apr 2002 08:57:58 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: "use"
In-Reply-To: <20020428200027.717963850@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204290854320.19520-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 28 Apr 2002, Russell Coker wrote:

> What's the deal with the following section of the global macros file?  Why
> are there three things aliased to use?  Is the plan to actually enforce a
> distinction in a future version?  Or did a past version support a distinction
> and is this a compatability thing?
>
> #
> # Permissions to use file descriptions created by another domain.
> #
> define(`use_fd_perms', `use')
> define(`inherit_fd_perms', `use')
> define(`receive_fd_perms', `use')

The original (pre-LSM) SELinux provided a distinction among these three
cases that was eliminated from the LSM-based SELinux.  The macros were
retained for compatibility, but there is no intent to revive the
distinction.  This change is documented more completely along with a
summary of all the changes between the original SELinux and the LSM-based
SELinux in a technical report that is pending release approval from the
NSA.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
