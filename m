Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25476
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 13:16:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA08796
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 18:16:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id SAA08792
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 18:16:02 GMT
Date: Tue, 6 Nov 2001 13:15:36 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Femitha Majeed <m_femitha@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Flask architecture
In-Reply-To: <F1517q0JrAncMvgRFLq0000b8d6@hotmail.com>
Message-ID: <Pine.GSO.4.33.0111061302180.11349-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 6 Nov 2001, Femitha Majeed wrote:

> Hi, I have question about implementation of Flask architecture.
>
> Are SIDs unique? How does the security server assign an SID to a new object
> given the security contexts(or SIDs) of related objects?

You'll find quite a bit of information about this in the papers and
technical reports available on the Documentation and Background pages at
the NSA SELinux web site.  As for your specific question, SIDs do not
uniquely identify individual subjects or objects; they identify
security contexts (aka security labels).  The security server determines a
security context for a new subject or object based on some default logic
and the policy rules, and then returns a SID that corresponds to that
security context, possibly generating a new SID if one does not already
exist for the context.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
