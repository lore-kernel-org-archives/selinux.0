Message-ID: <4D2DFA15.60805@redhat.com>
Date: Wed, 12 Jan 2011 13:59:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy compiler doesn't like leading numbers in fs names
References: <4D2DF4BC.1030004@redhat.com> <1294858566.2276.9.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1294858566.2276.9.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/12/2011 01:56 PM, James Carter wrote:
> On Wed, 2011-01-12 at 13:36 -0500, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=668871
> 
> Is there any logical reason for this or is this just a bug?
> 
>> The filesystem name for a genfscon statement happens to be specified as
>> an identifier and an identifier must begin with a letter, but I don't
>> think that there is any technical reason for the restriction.
> 
>> Would we want to allow all identifiers to be able to start with
>> alphanumeric characters (or maybe even "_") or just filesystem names?
> 
>>
- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

I would say allow any alphanumeric and _, and then let the refpolicy
guidelines control what gets into that policy.  Forcing IBM to change
the name of their file system for SELinux seems a little nuts.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0t+hUACgkQrlYvE4MpobMT2gCeMA/lLDF4bv1+rgNesFlHR42P
fIEAn06YCwRWmIrtjAvJIhwT+uQbOCfU
=L6cW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
