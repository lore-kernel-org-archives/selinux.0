Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01336
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 12:16:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA05413
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:16:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA05409
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:16:23 GMT
Date: Wed, 10 Jan 2001 12:15:42 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Jose Nazario <jose@biocserver.bioc.cwru.edu>
cc: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>, selinux@tycho.nsa.gov
Subject: RE: Security enhancements, et al
In-Reply-To: <Pine.LNX.4.30.0101101209420.30847-100000@biocserver.BIOC.CWRU.Edu>
Message-ID: <Pine.SOL.3.95.1010110121106.16290O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Wed, 10 Jan 2001, Jose Nazario wrote:

> i just started using it last night. if i understand it correctly, trusted
> os concepts and implementations are new-ish to me, SELinux is just policy
> definitions but no enforcement yet, and RSBAC actually can enforce those
> policies. hence, RSBAC looks more complete *at this time* than SELinux is.

This is not correct.  SELinux is an implementation of a flexible
mandatory access control architecture in the Linux kernel, including
both enforcement and policy components.  The paper accessible via
http://www.nsa.gov/selinux/slinux-abs.html provides a detailed description
of the precise controls provided by SELinux.  SELinux also provides an
example security policy configuration that meet a number of security
goals.  This example security policy configuration is described in detail
in the paper accessible via http://www.nsa.gov/selinux/policy-abs.html.
Both of these papers are accessible through the Documentation page
and are included in the distribution.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
