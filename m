Message-ID: <479789E3.3060007@redhat.com>
Date: Wed, 23 Jan 2008 13:39:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to add python audit2why bindings.
References: <4787936A.8030803@redhat.com> <1201098728.7025.270.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201098728.7025.270.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-01-11 at 11:03 -0500, Daniel J Walsh wrote:
> Updated policycoreutils will be coming to take advantage of these bindings.
> 
> setroubleshoot will also.
> 
> import selinux
> 
> will work the way it always did, but now you can execute
> 
> import selinux.audit2allow as audit2allow
> 
> audit2allow.init()
> 
> for i in avc:
> 	print audit2allow.analyze(i.scon, i,tcon, i,class, i.access)
> 
> audit2allow.finish()
> 
> And get the reason for the AVC.
> 
>> The Makefile changes are broken:
>> make DESTDIR=~/obj install install-pywrap > outinstall: accessing
>> `/home/sds/obj/usr/lib/python2.5/site-packages/selinux/__init__.py': Not
>> a directory
>> make[1]: *** [install-pywrap] Error 1
>> make: *** [install-pywrap] Error 2
> 
Works for me?

THis directory should have been created by the Makefile?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeXieMACgkQrlYvE4MpobMuDQCfajj6hcQlfjwWasgsv9lLfKcS
b7wAoL+EWV3I1K/6FTmB9PPFLoaoW4dd
=9Twz
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
