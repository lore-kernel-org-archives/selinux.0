Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06843
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:01:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA24863
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:00:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA24859
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:00:43 GMT
Date: Tue, 27 Aug 2002 10:01:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs change, trivial patches, netscape & x patches
In-Reply-To: <20020826182454.9C15B4E2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208270946320.11201-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These three patches have been merged and are available in the sourceforge
CVS tree, with the following exceptions from triv.diff:
1) login.te:  remote_login_t, the domain of a login process spawned by
rlogind, is only granted domain_trans() to unpriv_userdomain, not
userdomain.
2) oav-update.te:  There was a spurious amavisd rule in this file, likely
a cut-and-paste error.  Removed.
3) global_macros.te:  daemon_base_domain() should not need to include
init_t in the domain_auto_trans() rule, unless some of these daemons are
truly started directly by init.  The separate type_transition init_t rule
should be sufficient to deal with the reparenting issue when using
SELinux as a dynamically loaded module, which isn't recommended anyway.
4) sendmail.fc:  We don't want to remove the /etc/aliases entries or the
sendmail executable entries for people running sendmail.

With regard to the netscape changes, note that netscape can still read
files in the user home type for the .Xauthority file.  We need to place
this file into its own type, with a separate domain for the xauth program.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
