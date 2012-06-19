Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5JEPLXq032244
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2012 10:25:21 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for selinux@tycho.nsa.gov with esmtp
          (envelope-from <h.v.bruinehsen@fu-berlin.de>)
          id <1SgzMs-0004to-Hj>; Tue, 19 Jun 2012 16:25:18 +0200
Received: from imp051235.vpn.mi.fu-berlin.de ([130.133.51.235])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          for selinux@tycho.nsa.gov with esmtpsa
          (envelope-from <h.v.bruinehsen@fu-berlin.de>)
          id <1SgzMs-0000I4-Eb>; Tue, 19 Jun 2012 16:25:18 +0200
Message-ID: <4FE08BCC.2040703@fu-berlin.de>
Date: Tue, 19 Jun 2012 16:25:16 +0200
From: Hinnerk van Bruinehsen <h.v.bruinehsen@fu-berlin.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: KDE and SE Linux
References: <201206181803.59321.russell@coker.com.au> <1340109645.18291.26.camel@moss-pluto.epoch.ncsc.mil> <4FE074E4.3030909@redhat.com>
In-Reply-To: <4FE074E4.3030909@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19.06.2012 14:47, Daniel J Walsh wrote:
> On 06/19/2012 08:40 AM, Stephen Smalley wrote:
>> On Mon, 2012-06-18 at 18:03 +1000, Russell Coker wrote:
>>> The current version of KDE in Debian is 4.8.4, it seems that
>>> large parts of the KDE environment depend on execmem access,
>>> this includes kwin and plasma- desktop.  Basically there is no
>>> possibility of having a KDE desktop environment without them.
>>> 
>>> Debugging this is difficult as the important programs SEGV when
>>> denied execmem access and the KDE crash handler really gets in
>>> the way of debugging it - running /usr/bin/plasma-desktop
>>> results in the process forking a child and detaching from the
>>> gdb session.
>>> 
>>> The most clear example of an execmem issue in KDE is from the
>>> program /usr/lib/kde4/libexec/kwin_opengl_test which gives the
>>> following error: LLVM ERROR: Allocation failed when allocating
>>> new memory in the JIT Can't allocate RWX Memory: Permission
>>> denied
>>> 
>>> What should I do?  Obviously setting the allow_execmem makes
>>> things work, but that also allows a lot of unwanted stuff.
>>> 
>>> I could label the programs in question as unconfined_execmem_t,
>>> but that would rely on finding all of them and would also give
>>> a problem for sessions with the user_t domain.
>>> 
>>> Is it possible to change the way KDE works or is there any
>>> other easy fix?
> 
>> Not sure if this has been discussed anywhere, but looks like the
>> _execmem_t domains have gone away in modern Fedora, execmem is
>> allowed by default, and there is a deny_execmem boolean for
>> disabling it.  So it appears that they at least gave up on
>> restricting it by default.
> 
> 
> Yes for users we have pretty much given up on confining execmem,
> because so many of the modern desktop is building in JRE, along
> with Firefox/Thunderbird requiring it.  It becomes obvious that the
> memory checks for a desktop user conflict totally with the
> usefulness of the desktop.
> 
> 

Hi,

coming from a Gentoo perspective and using a fully hardened desktop, I
have to add a little bit of information here:

Firefox/Thunderbird both run fine with noexecmem (PaX mprotect to be
more specific) with the exception of some plugins like flash.
For Thunderbird, Firefox and at least some parts of QT there are
compile-time options to disable jit (in Gentoo represented by useflags).
If I recall correctly there are also some Gentoo devs who run KDE on
hardened (I use gnome).

I'm not sure how feasible it would be to distribute "no-jit" binaries,
though.

WKR
Hinnerk


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJP4IvMAAoJEJwwOFaNFkYc8PEIAK+6z7JG48Fw6o5oOc4uy3By
qqN5K0iGVVR+It6et1n8wsnBvasYH34thVw+G6T+5P4ZmhJzYLAqVgOVFwJ3bp2t
7abKNnX3UNMICCWDDGnNuq8jqTfnIHfodOECqW1N5VKYvMNYMRxzbT4gg65ZZMSb
3wHXAyyR609lb1/PiaCVU5Oqj1BobrcGcWvsDqJlU/rQ2fEWqVz3O31i+7/9zfLu
MPZOGTGceJdo8RaARpfxunlaWgwuZljgQXU+5x/i+iRzLT9K7Lr8wiiL/YeWFy4U
TPsSF14hdSRlClxkqzSl+yormKfTDqjg0bkLaYDMdF1lENqJ2Tbi1IxTDEZzXQo=
=0AYz
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
