Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA18668
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 11:30:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA08529
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 16:29:13 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA08525 for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 16:29:12 GMT
Date: Tue, 26 Feb 2002 11:29:51 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: pptp and SELinux errors
In-Reply-To: <1652.192.168.1.12.1014735791.squirrel@192.168.1.2>
Message-ID: <Pine.GSO.4.33.0202261120270.9954-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 26 Feb 2002, Lonnie Cumberland wrote:

> I now have the pppd_te files that you were talking about, but was
> wondering if it would be easier to just add the pptp daemon to a
> domain that already had these permissions as you have previously
> mentioned?
>
> If so then how might I go about that?

I'd suggest merging Russell Coker's pppd_t domain (since pptpd is
obviously running pppd), and then determine whether pptpd should run in
the same domain or whether it requires its own domain (that transitions
to pppd_t upon running pppd).  If you want to run pptpd in the same domain
as pppd, then simply assign the pptpd executable the pppd_exec_t type and
then restart the daemon.

The quick way to assign pptpd executable the pppd_exec_t type is to use
chcon, e.g. chcon system_u:object_r:pppd_exec_t /usr/sbin/pptpd.  However,
it is generally advisable to also update your setfiles/file_contexts file
so that subsequent 'make relabel' commands will preserve the type.

When starting the daemon, you should be using run_init on the rc script
for starting/stopping the daemon rather than directly starting it.
Otherwise, it won't end up with the right security context.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
