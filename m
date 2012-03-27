Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2REOMbi020837
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 10:24:22 -0400
Message-ID: <4F71CD93.5070108@redhat.com>
Date: Tue, 27 Mar 2012 10:24:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/4] libsemanage -- Do not link against libpython, this
 is considered bad in Debian
References: <20120326160452.1d129dc4@eldamar.bigon.be>
In-Reply-To: <20120326160452.1d129dc4@eldamar.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/26/2012 10:04 AM, Laurent Bigonville wrote:
> Hi,
> 
> Do not link against libpython, the interpreter is already linked to
> it. In Debian this is usually considered bad practice.
> 
> Laurent
> 
> Description: Do not link against libpython, this is considered bad
> practice in Debian Author: Laurent Bigonville <bigon@debian.org> 
> Date: Wed, 07 Mar 2012 14:21:48 +0100
> 
> --- a/libsemanage/src/Makefile +++ b/libsemanage/src/Makefile @@
> -77,7 +77,7 @@ $(CC) $(filter-out -Werror, $(CFLAGS)) -I$(RUBYINC)
> -fPIC -DSHARED -c -o $@ $<
> 
> $(SWIGSO): $(SWIGLOBJ) -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@
> $< -L. -lsemanage -L$(LIBDIR) $(PYTHONLIBDIR)
> -Wl,-soname,$@,-z,defs +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@
> $< -L. -lsemanage -L$(LIBDIR) -Wl,-soname,$@
> 
> $(SWIGRUBYSO): $(SWIGRUBYLOBJ) $(CC) $(CFLAGS) $(LDFLAGS) -shared
> -o $@ $^ -L. -lsemanage -L$(LIBDIR) -Wl,-soname,$@
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 


THis seems to work fine in Fedora.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9xzZMACgkQrlYvE4MpobNkvgCfZZ4Lpkm1azDTeuadZrMUyYsh
gTQAn2+dOdZDPvLxGTqynQAW3QbTKFjl
=7MIQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
