Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28422
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 09:01:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA20102
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 13:59:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA20098
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 13:59:53 GMT
Date: Fri, 15 Mar 2002 09:00:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
In-Reply-To: <20020314203149.4BB5519FE7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203150854350.15480-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 14 Mar 2002, Russell Coker wrote:

> To solve this I was thinking of having an automatic transition from sysadm_t
> to dpkg_t when dpkg_exec_t programs are run.  Then there would be an
> automatic transition from dpkg_t when running initrc_exec_t binaries (all the
> start scripts) which stops run_init from needing a password.
>
> What do you think of this idea?

I'm not sure I understand.  run_init (or something similar) still needs to
be used when running the init scripts so that they are executed from the
proper security context.  run_init re-authenticates for the same reason as
newrole - to ensure that the user really wants to perform the transition,
as opposed to some malicious code run by the user.  If you eliminate the
user interaction for dpkg, how do you provide the same guarantee?  Or, if
you are willing to give up that guarantee, then why not just drop the
authentication out of your copy of run_init entirely.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
