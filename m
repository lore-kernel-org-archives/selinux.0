Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NGauDp005255
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 12:36:56 -0400
Received: from mail.fluendo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5NGatGK010263
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 16:36:56 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id 9EE6F25008B
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 18:36:54 +0200 (CEST)
Received: from [192.168.0.2] (17.84.219.87.dynamic.jazztel.es [87.219.84.17])
	by mail.fluendo.com (Postfix) with ESMTP id 637C7250086
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 18:36:54 +0200 (CEST)
Message-ID: <485FD15F.4080304@flumotion.com>
Date: Mon, 23 Jun 2008 18:37:51 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How to disable/remove MLS
References: <485FC1FB.3030605@flumotion.com>	 <1214237136.32762.64.camel@moss-spartans.epoch.ncsc.mil>	 <485FCB72.9030407@flumotion.com> <1214238707.32762.86.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1214238707.32762.86.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thank you, indeed that was it.

Stephen Smalley wrote:
| On Mon, 2008-06-23 at 18:12 +0200, Ioannis Aslanidis wrote:
|> -----BEGIN PGP SIGNED MESSAGE-----
|> Hash: SHA1
|>
|> Hello and thank you for the reply.
|>
|> The problem here is that we also work with older systems (FC5) which do
|> not have MCS implemented and cause compatibility problems when saving
|> configuration file contexts. Migrating to a newer version is planned,
|> but it will take a long while. In the meanwhile we need an intermediate
|> solution.
|>
|> In RHEL 5.1/5.2 is where I see the ':s0' tag when I do ls -Z. Any clues
|> about that?
|
| I believe that FC5 and RHEL5 have MCS enabled.  But the :s0 is hidden if
| you are running mcstrans.
|
| /sbin/service mcstrans status
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkhf0V8ACgkQFq+8w76sCAB6sgCgqACjQAjiNN1LzDXvC2T0l5Ws
XsAAn33yCX6ALnQoSGrNkuZ+NpFfghtG
=rtFI
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
