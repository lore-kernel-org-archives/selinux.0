Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA22614
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 15:10:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA08914
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:08:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA08910 for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:08:22 GMT
Date: Tue, 29 Oct 2002 15:09:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: New configuration scheme
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524440@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0210291507370.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Oct 2002, Westerman, Mark wrote:

> Since the configuration scheme has change (i.e. new default_context ....)
> will that beak any program that were based on the old one or is it
> backward compatible?

The new default_context file has a different syntax and the new libsecure
functions have different interfaces.  The old configuration files are no
longer installed or used by the upstream SELinux.

> IOW will I have to recode the gdm login sections.

Yes, you will likely need to do that.  Notice that the new libsecure
functions internally use security_get_user_sids to obtain the full list of
legal SIDs for the user that are reachable from the current process and
then determine a default based on the new config file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
