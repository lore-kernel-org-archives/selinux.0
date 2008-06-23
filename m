Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NGBdjv032567
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 12:11:39 -0400
Received: from mail.fluendo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5NGBcFO014100
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 16:11:38 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id 2273A250122
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 18:11:37 +0200 (CEST)
Received: from [192.168.0.2] (17.84.219.87.dynamic.jazztel.es [87.219.84.17])
	by mail.fluendo.com (Postfix) with ESMTP id AB393250086
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 18:11:36 +0200 (CEST)
Message-ID: <485FCB72.9030407@flumotion.com>
Date: Mon, 23 Jun 2008 18:12:34 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How to disable/remove MLS
References: <485FC1FB.3030605@flumotion.com> <1214237136.32762.64.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1214237136.32762.64.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello and thank you for the reply.

The problem here is that we also work with older systems (FC5) which do
not have MCS implemented and cause compatibility problems when saving
configuration file contexts. Migrating to a newer version is planned,
but it will take a long while. In the meanwhile we need an intermediate
solution.

In RHEL 5.1/5.2 is where I see the ':s0' tag when I do ls -Z. Any clues
about that?

Regards,

Ioannis

Stephen Smalley wrote:
| Whether or not MLS is enabled is defined by your policy build options.
| In refpolicy, this is determined by the TYPE= setting in build.conf.
| The upstream refpolicy defaults to "standard", which leaves MLS
| disabled.  Fedora and RHEL use "mcs", which enables the MLS engine and
| field but only uses categories with a different set of constraints than
| "mls".  Fedora and RHEL also run mcstransd, a daemon for label
| translation, which by default strips the ":s0" suffixes so that users
| don't see them.
|
| Disabling MCS/MLS in Fedora or RHEL may cause compatibility problems.
| Such compatibility issues should be reported as bugs, since application
| code should remain independent of policy, but such bugs have been
| encountered in the past, and most users of Fedora and RHEL only use the
| default policy that enables MCS.
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkhfy3IACgkQFq+8w76sCABQmgCfRiawui0m9d6iJhX+an6SqTlq
ge8AoKvM6SfKTOWRHs7zaY37Uhq/qzeF
=1gSQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
