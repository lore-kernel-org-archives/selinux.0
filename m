Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA28119
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 11:56:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11420
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 16:55:07 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA11416 for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 16:55:06 GMT
Date: Tue, 12 Mar 2002 11:55:27 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Firewall Policy
In-Reply-To: <20020312162911.5C7F75953@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203121141220.16482-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 12 Mar 2002, Russell Coker wrote:

> Please send me the RPM sample policy ASAP so I can get you a policy for dpkg,
> dselect, and apt-get in time for the next release!!!

We aren't committing any further changes for the next public release,
excluding any critical bug fixes.  So this will have to wait.  In any
event, this domain is very simple and is merely to support the
execution of rpm by the /etc/cron.daily/rpm script on RH7.2.  When an
administrator process runs rpm, it remains in sysadm_t, which already has
sufficient permissions.

> Can't this all go through nscd?  If so then all you need is nscd access (unix
> domain socket) for all those applications.

Possibly, if you run nscd and all applications go through nscd to perform
such queries.  But that is an environmental assumption that may not apply
to all users.

> Does NFS access go through the security policy as network access?  Surely NFS
> would be regarded as regular access to untyped files?

On second thought, I think that NFS requests are proxied through a UDP
socket created by mount, so it should be sufficient to grant access to
this socket rather than directly granting network access.  We haven't
truly addressed NFS in SELinux, as I've mentioned previously.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
