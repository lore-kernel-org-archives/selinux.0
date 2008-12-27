Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBRBJO2j021102
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 06:19:24 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBRBGrd0028916
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 11:16:53 GMT
Message-ID: <49560F36.20303@redhat.com>
Date: Sat, 27 Dec 2008 06:19:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: transition policy/logic for shell-, perl- and python-scripts
References: <1230370454.2932.11.camel@localhost.localdomain>
In-Reply-To: <1230370454.2932.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> Hello everyone,
> 
> I would like to know the policy/logic for transition of e.g. a
> Perl-Script. If I write a daemon in Perl, label the file as
> daemon_exec_t and execute it using the initrc_t, then the daemon runs
> under the daemon_t domain. This SELinux behavior is very convenient.
> 
> I would like to know when and how does a transition for such a script
> occur?
> 
> For example, create a /tmp/test.pl and run it. The file is labeled as 
> 
> unconfined_u:object_r:user_tmp_t:s0
> 
> but runs as
> 
> unconfined_u:unconfined_r:unconfined_t:s0
> 
> Therefore, no type transition occurred. Can someone give me a hind?
> 
> cheers,
> Stefan
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
The default policy for unconfined_t is that it can execute any file type
without a transition.  So a unconfined_t executing a user_tmp_t would
stay unconfined_t.  Similarly initrc_t can execute most bin_t files
without a transition, so initrc_t executing files in a bin directory
with the default labeling will stay bin_t.  Now if you define a file
context for a daemon, daemon_exec_t.  And you define a domain type for
this daemon daemon_t.  You can call an interface

init_daemon_domain(daemon_t, daemon_exec_t)

Which will cause initrc_t to transition to daemon_t when it executes
files labeled daemon_exec_t.  This transition happens when the
executable starts.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklWDzYACgkQrlYvE4MpobMgXACeKGec0qzW2D/W2a2FfTtk2MMG
Fm4AnisJ+7w97Q6eepCyGdUc+cOContp
=Zsgr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
