Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14069
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 07:54:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA07875
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:54:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA07871
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:54:03 GMT
Date: Mon, 22 Jul 2002 07:54:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: default context files
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIKENIKEAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0207220750160.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 19 Jul 2002, Frank Mayer wrote:

> Is there a reason why the cron_context file has a specific type
> (cron_context_t) and the default_context file has the generic etc_t type?
> We're trying to give a domain the ability to write both context files, and
> it seems excessive for it to have the ability to modify all files with etc_t
> type.  Frank

We haven't previously needed to grant selective write access to the
default_context (or default_type) files, so it hasn't been necessary to
have a separate type.  MITRE defined a separate type for cron_context when
they worked on the crond policy.  Feel free to submit patches to the
policy and file_contexts configurations to provide separate types for the
default_context/type files.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
