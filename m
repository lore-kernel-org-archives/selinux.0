Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23837
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 12:50:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA14117
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 17:49:51 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id RAA14113
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 17:49:50 GMT
Date: Tue, 15 Jan 2002 12:49:59 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: General Users
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0201151245020.2365-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Jan 2002, Westerman, Mark wrote:

> The current implementation of SELinux requires each user to be listed in the
> user policy file and the default_context.

The per-user entries of default_context and cron_context will no longer be
necessary when we migrate to the default_contexts file and the new
libsecure functions.  See my message on that topic from Jan 7th.  I think
that work on the new configuration file and the new libsecure functions
has resumed by the original developer, but I don't know when the migration
will be complete.

> What would be the best way to modify the current implement to create a
> standard
> user. I was thinking of setting up a standard user for the user policy file
> and
> for the default context in the /etc/security (cron and default). I am
> looking at modifying
> the libsecure to look at the user, if the user is not found in the
> default_context file
> then assign him the standard user context.

This approach should work if you merely want to map most users to a single
set of authorized roles and if you are not concerned about using the
SELinux user identity to provide per-user accountability for most users.
Otherwise, you'll need a more sophisticated solution.  If you make
modifications to the libsecure functions, be aware that the old functions
will be obsoleted by the new ones at some point in the future.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
