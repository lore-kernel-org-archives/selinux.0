Message-ID: <50278D98.5060801@redhat.com>
Date: Sun, 12 Aug 2012 07:03:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Lennart Poettering <lennart@poettering.net>
CC: russell@coker.com.au, Colin Walters <walters@verbum.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: A filename to label translation daemon
References: <1344454290.25533.12.camel@localhost> <201208100037.21877.russell@coker.com.au> <5023EE1C.5060205@redhat.com> <201208101228.11637.russell@coker.com.au> <502500ED.5050502@redhat.com> <20120810140503.GB32076@tango.0pointer.de>
In-Reply-To: <20120810140503.GB32076@tango.0pointer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/10/2012 10:05 AM, Lennart Poettering wrote:
> On Fri, 10.08.12 08:39, Daniel J Walsh (dwalsh@redhat.com) wrote:
> 
>>>>> What benefit are we expecting to get here?
>>>> 
>>>> kerberos library currently does a matchpathcon on /tmp/BLAH files
>>>> and sets the label correctly.  With this change in the library we are
>>>> seeing huge performance hits of apache services caused by loading the
>>>> regex.
>>> 
>>> What is kerberos doing under /tmp and why is it being done repeatedly
>>> by different processes?
>>> 
>> Actually /var/tmp/HOST_0 /var/tmp/HTTP_23 ...  Kerberos Replay Cache.
>> Every time someone contacts an apache server using kerberos it needs to
>> update this file, it does this via mktemp (/tmpHTTPD_23XXXX), rename.
> 
> Hmm, but the ultimate name is still guessable? That sounds really 
> dangerous. Guessable names in /tmp (or /var/tmp) are prone to DoS 
> attacks...
> 
> Lennart .
One would guess that the Kerberos Libraries handle this situation, since it
has been doing it for years.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAnjZcACgkQrlYvE4MpobOMFACeJQf3CDtrM5qjk8X6LWYAlstn
1o0AoJsmWO7cOrCGhrkOD8gQ+5+envFI
=rbUn
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
