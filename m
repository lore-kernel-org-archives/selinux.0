Subject: Re: SELinux Policy compiler doesn't like leading numbers in fs
 names
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4D2DF4BC.1030004@redhat.com>
References: <4D2DF4BC.1030004@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Jan 2011 13:56:06 -0500
Message-ID: <1294858566.2276.9.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-01-12 at 13:36 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=668871
> 
> Is there any logical reason for this or is this just a bug?

The filesystem name for a genfscon statement happens to be specified as
an identifier and an identifier must begin with a letter, but I don't
think that there is any technical reason for the restriction.

Would we want to allow all identifiers to be able to start with
alphanumeric characters (or maybe even "_") or just filesystem names?

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk0t9LwACgkQrlYvE4MpobOnqACg4Hj22Ioqgopb96HTvJ0ZkrmO
> 02gAnAlpIDBLjSTQkoOvah/S535YePCM
> =65GT
> -----END PGP SIGNATURE-----
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
