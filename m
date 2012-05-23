Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4NFkRVU029522
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2012 11:46:27 -0400
Message-ID: <4FBD064B.5040707@redhat.com>
Date: Wed, 23 May 2012 11:46:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: sepolgen requires unofficial setools patch
References: <20120521205849.GA8511@siphos.be>
In-Reply-To: <20120521205849.GA8511@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/21/2012 04:58 PM, Sven Vermeulen wrote:
> Hi guys,
> 
> It looks like the current stable sepolgen release has requirements towards 
> an unofficial (well, fedora/rhel only) patch on setools. With the current 
> stable setools, it gives the following error when trying to use
> audit2allow on a denial that contains write & open:
> 
> Traceback (most recent call last): File "/usr/bin/audit2allow-2.7", line
> 354, in <module> app.main() File "/usr/bin/audit2allow-2.7", line 345, in
> main self.__output() File "/usr/bin/audit2allow-2.7", line 315, in
> __output g.add_access(self.__avs) File
> "/usr/lib64/python2.7/site-packages/sepolgen/policygen.py", line 211, in
> add_access self.__add_allow_rules(raw_allow) File
> "/usr/lib64/python2.7/site-packages/sepolgen/policygen.py", line 179, in
> __add_allow_rules self.domains = seinfo(ATTRIBUTE,
> name="domain")[0]["types"] NameError: global name 'seinfo' is not defined
> 
> The patch that RedHat (and Fedora) provides fixes this in Python 2
> systems, but doesn't work in Python 3 (because Python 3 has a different
> setup for Extension-based modules). I have a locally-tested patch on that,
> but I'm not sure this is a good way to go forward.
> 
> Perhaps it would be wise to remove the dependency towards the setools 
> binding and instead include the necessary code in the userspace libraries 
> themselves? policygen.py doesn't require the entire set of querying that 
> seinfo provides...
> 
> The patch that is suggested by RedHat/Fedora doesn't follow the same 
> structure as the other bindings do (like libqpol/libapol) in setools too.
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.


Well I am not sure if anyone has ever used the setools python binaries other
then the setools/sesearch and seinfo bindings.

I would suggest we drop the general python bindings or deemphasize them and
work on improving the seinfo/sesearch bindings.

I have generated quite a few tools based on these bindings, that I am trying
to figure out where how to package.

setrans, senetwork, secommunicate,  segenuserman, segendomainman

Currently these are just little python scripts but I think they are pretty
powerfull and if we figured out a good cli for them, would be a nice update of
settools.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+9BksACgkQrlYvE4MpobNzIACgosigCJ247v7KA/g7nG+qusLR
EOwAoJQs6HK+VuP01ZclQbCHac2gvzZA
=Ow4G
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
