Message-ID: <5023EE1C.5060205@redhat.com>
Date: Thu, 09 Aug 2012 13:06:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Colin Walters <walters@verbum.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov
Subject: Re: A filename to label translation daemon
References: <1344454290.25533.12.camel@localhost> <1344461186.4612.27.camel@lenny> <201208100037.21877.russell@coker.com.au>
In-Reply-To: <201208100037.21877.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/09/2012 10:37 AM, Russell Coker wrote:
> On Thu, 9 Aug 2012, Colin Walters <walters@verbum.org> wrote:
>> Seems to make sense...though someone could also probably get fairly far 
>> by writing a regular expression optimizer.  It might not even be that 
>> hard to write a multi-regexp matching engine which took a set of regexps 
>> at once and constructed a single matching DFA for them.
> 
> Is this really going to help?  My slowest system is a P3-866 which takes
> less than 30ms of user time for "restorecon /bin/bash" and takes a total of
> 136ms of wall time if the cache is cold.  On a 1.8GHz 64bit system it's
> only 8ms of user time.
> 
> What benefit are we expecting to get here?
> 
kerberos library currently does a matchpathcon on /tmp/BLAH files and sets the
label correctly.  With this change in the library we are seeing huge
performance hits of apache services caused by loading the regex.

Running make install has caused a huge hit if you are running thousands of
install commands which caused the remove of labeling from the install command.

Systemd has been is executing the load load many many times and is showing up
to 1 second slow down on startup.  If the startup is 10 seconds, it is kind of
hard to justify 10% slowdown on boot.

I believe we just add support for this service and have the labeling fall back
to the default if the labeling socket does not exists, and then distributions
can decide whether or not they want to use it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAj7hsACgkQrlYvE4MpobM/BACfdD0TsYmGFyRc6vh+P4xIMcUB
wzEAn2fTC1sAO7MsA7xlBZoAvmfJsBDI
=bIvH
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
