Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA25566
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 07:40:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA28621
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 11:39:08 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA28617
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 11:39:08 GMT
Date: Fri, 16 Aug 2002 07:39:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: /bin/login
In-Reply-To: <20020816025641.364C683A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208160728480.29385-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 16 Aug 2002, Russell Coker wrote:

> During the login process we see the following prompts for a non-default
> security context.  Shouldn't the last prompt be "Enter domain" not
> "Enter type"?

Yes and no.  As explained in the Security Model section of the Configuring
the SELinux Policy report (as well as in the older policy report and in
the Ottawa paper), the SELinux TE model does not internally distinguish
domains from types and uses a single type attribute in the security
context for both processes and objects.  Hence, "Enter type" is
legitimate, as is name for the /etc/security/default_type file.  However,
if we want to use the language of the traditional TE model, we could make
this "Enter domain" and /etc/security/default_domain.  No big deal either
way.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
