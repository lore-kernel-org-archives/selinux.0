Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05885
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:51:32 -0400 (EDT)
Date: Tue, 1 Oct 2002 12:50:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: apache
In-Reply-To: <200209272327.56232.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011250160.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 27 Sep 2002, Russell Coker wrote:

> I've attached a patch for the apache policy.
>
> If someone here knows the Apache source then the best solution would be to get
> the Apache source patched to set the file handle in question to close on
> exec...

Thanks, merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
