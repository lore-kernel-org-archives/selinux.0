Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6LAbXIl014744
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2013 06:37:37 -0400
Message-ID: <51EBB9DC.8000400@redhat.com>
Date: Sun, 21 Jul 2013 06:37:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] sepolgen: Fix AttributeError: 'dict' object has no
 attribute 'attributes'
References: <20130719201152.GB20879@siphos.be>
In-Reply-To: <20130719201152.GB20879@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/19/2013 04:11 PM, Sven Vermeulen wrote:
> 
> While running the tests, the test_export one fails as follows:
> 
> ====================================================================== 
> ERROR: test_export (test_interfaces.TestInterfaceSet) 
> ---------------------------------------------------------------------- 
> Traceback (most recent call last): File
> "/var/portage/portage/dev-python/sepolgen-1.1.9-r1/work/sepolgen-1.1.9-2.7/tests/test_interfaces.py",
> line 263, in test_export i.add_headers(h) File
> "../src/./sepolgen/interfaces.py", line 412, in add_headers self.add(i,
> attributes) File "../src/./sepolgen/interfaces.py", line 407, in add ifv =
> InterfaceVector(interface, attributes) File
> "../src/./sepolgen/interfaces.py", line 257, in __init__ 
> self.from_interface(interface, attributes) File
> "../src/./sepolgen/interfaces.py", line 279, in from_interface if not
> attributes.attributes.has_key(attr): AttributeError: 'dict' object has no
> attribute 'attributes'
> 
> The test does not declare the attributes parameter (it is optional) so it 
> becomes the empty dictionary object.
> 
> Changing "if attributes != None:" to "if attributes:" gets the tests to
> succeed and the code still seems to function correctly (ran
> "sepolgen-ifgen" and "sepolgen-ifgen -i /usr/share/selinux/strict/include"
> to trigger the code).
> 
> Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be> --- 
> sepolgen/src/sepolgen/interfaces.py | 2 +- 1 file changed, 1 insertion(+),
> 1 deletion(-)
> 
> diff --git a/sepolgen/src/sepolgen/interfaces.py
> b/sepolgen/src/sepolgen/interfaces.py index ae1c9c5..88a6dc3 100644 ---
> a/sepolgen/src/sepolgen/interfaces.py +++
> b/sepolgen/src/sepolgen/interfaces.py @@ -273,7 +273,7 @@ class
> InterfaceVector: self.add_av(av)
> 
> # Add typeattribute access -        if attributes != None: +        if
> attributes: for typeattribute in interface.typeattributes(): for attr in
> typeattribute.attributes: if not attributes.attributes.has_key(attr):
> 

Applied to Fedora.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHrudwACgkQrlYvE4MpobM7nwCdGVBVL8av5U5vsNOlNqiXvdLi
C8kAoJY8camlRWXeTx9+bWgZQIfRgHTv
=InTW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
