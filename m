Message-ID: <4D77A141.6030908@redhat.com>
Date: Wed, 09 Mar 2011 10:48:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Subject: Re: libselinux version bump past 99
References: <4D76AD1C.8080901@tycho.nsa.gov> <1299675962.4884.7.camel@moss-pluto>
In-Reply-To: <1299675962.4884.7.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/09/2011 08:06 AM, Stephen Smalley wrote:
> On Tue, 2011-03-08 at 17:26 -0500, Eamon Walsh wrote:
>> Libselinux has reached version 2.0.99 and I need to push a bug fix, just checking to make sure 2.0.100 is fine and won't cause any problems e.g. with upgrades.
> 
> Shouldn't be a problem.  However, it does raise the question of when
> we'll move to 2.1.0.  If the version string consists of
> major.minor.revision, then possibly we should be incrementing minor and
> resetting revision whenever there is a new release on
> userspace.selinuxproject.org?
> 
Make sense to me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk13oUEACgkQrlYvE4MpobNdHwCgkTYbCc+K5ese7BudUBVZpkUb
VZ8AoKCPhpN3CoZN/LO1GNR5oJ3SwmSM
=6VnG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
