Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02257
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:26:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA11398
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:25:12 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA11393 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:25:12 GMT
Date: Thu, 21 Mar 2002 14:25:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: addition for xdm.te
In-Reply-To: <20020321155442.2550225CCC@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203211423480.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 21 Mar 2002, Russell Coker wrote:

> Regarding the file contexts.  What if we had the file contexts lines in the
> .te files?  We could have them prefixed by "###" so that they don't get
> parsed as domain rules but can be easily recognised in the policy.conf.  Then
> it would be a simple matter of:
> grep ^### policy.conf | cut -c 4-200 > file_contexts
>
> Or if ### in config files is too grungy for you then put the following in the
> macro file:
> define(`file_context', `###')dnl

I'd rather keep them as separate .fc files under the setfiles directory,
as in the archive that I sent earlier.  The file contexts configuration is
logically separate from the example policy configuration, and I'd like to
keep it physically separate as well.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
