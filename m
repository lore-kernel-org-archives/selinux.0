Message-ID: <50293B11.9010105@redhat.com>
Date: Mon, 13 Aug 2012 13:36:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Lennart Poettering <lennart@poettering.net>
CC: Colin Walters <walters@verbum.org>, russell@coker.com.au,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: A filename to label translation daemon
References: <1344454290.25533.12.camel@localhost> <1344461186.4612.27.camel@lenny> <201208100037.21877.russell@coker.com.au> <5023EE1C.5060205@redhat.com> <1344534669.8427.11.camel@lenny> <20120810141101.GC32076@tango.0pointer.de> <20120810141747.GA909@tango.0pointer.de>
In-Reply-To: <20120810141747.GA909@tango.0pointer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/10/2012 10:17 AM, Lennart Poettering wrote:
> On Fri, 10.08.12 16:11, Lennart Poettering (lennart@poettering.net) wrote:
> 
>>> * Your mmap file is in some data format - you can make up your own,
>>> but I like using
>>> http://developer.gnome.org/glib/stable/glib-GVariant.html * Check the
>>> timestamp on the regexp text file versus the cached copy, if newer, use
>>> the text file * Otherwise, mmap the cached blob, loop through each
>>> regexp, passing a pointer to the mmap cache file for regexec()
>> 
>> Well, the main bits are not actually stored in regex_t afaics. They are 
>> stored in regex_t::buffer. But that makes this kind of caching really 
>> difficult, because that is a pointer and storing a pointer in an mmap() 
>> region makes no sense.
>> 
>> Dunno, maybe another regex library is more suitable for this...
> 
> PCRE appears to be perfectly suited for this. See pcreprecompile(3). They
> have an interface explicitly designed for this. And PCRE is used by
> numerous projects already, so should be safe to use for SELinux too?
> 
> Lennart
> 
This seems like the best solution?  If upstream will accept it.  We could
rebuild the regex data when semanage modifies the file context.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlApOxEACgkQrlYvE4MpobOtgwCdGLgwt60AY3L+pHuQzQnrREEW
eQ4AoIgVktEglFqzInQJSZpUQLfEFk9H
=YWaU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
