Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15933
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 13:04:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA19738
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:02:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA19734
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:02:41 GMT
Date: Wed, 1 May 2002 13:03:28 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Security Context of nscd_socket
In-Reply-To: <3CCE4CFC.D18FF4E4@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0205011300330.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 30 Apr 2002, Carsten Grohmann wrote:

> Yesterday I rebuild the file security context and after this the nscd
> did not work, because the security context of the file
> /var/run/.nscd_socket was set to var_run_t and not to nscd_var_run_t.
> The policy denied the unlink of this file.
> A solution is to add follow line in the file file_context
> /var/run/.nscd_socket   system_u:object_r:nscd_var_run_t.
>
> Could anybody add this to the source code?

I'd suggest using <<none>> rather than a particular context for this type
of object in file_contexts, since the socket file should be recreated each
time by the daemon.  Notice that such an entry exists for the pid files.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
