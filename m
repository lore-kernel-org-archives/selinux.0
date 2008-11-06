Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6Gx5EV002120
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 11:59:05 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6Gx4Em025784
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 16:59:05 GMT
Message-ID: <49132254.2040600@redhat.com>
Date: Thu, 06 Nov 2008 11:59:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: LC Bruzenak <lenny@MagitekLtd.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: restorecon / matchpathcon
References: <1225987455.7321.37.camel@homeserver>	 <49131CD7.7070204@redhat.com> <1225989929.7321.39.camel@homeserver>
In-Reply-To: <1225989929.7321.39.camel@homeserver>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

LC Bruzenak wrote:
> On Thu, 2008-11-06 at 11:35 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> LC Bruzenak wrote:
>>> I see no way to recursively/silently check path context.
>>>
>>> The matchpathcon command has a silent but no recursive option. It does
>>> return non-zero if something doesn't match.
>>>
>>> The restorecon command has both recursive and don't change options but
>>> no silent. It does not return non-zero if there is a change to be made,
>>> so a redirect of stdout to /dev/null wouldn't suffice.
>>>
>>> Is there another way/command?
>>>
>>> Thx,
>>> LCB.
>>>
>> find | xargs matchpathcon?
> 
> I think in this case the $? return value would refer to the find not
> matchpathcon right?
> 
> LCB.
> 
matchpathcon -V PATH

Checks the context on disk versus the default, and sets the exit status
I believe.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkTIlQACgkQrlYvE4MpobMqgQCfRK/l0bIFWcmCENRN5EAamm7K
TnoAoOvhSz4nTk6fLso9rGJypGs9g6mT
=4hGy
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
