Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GHD9FN022464
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 13:13:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GHD8hc001422
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 17:13:09 GMT
Message-ID: <487E2C1F.4010308@redhat.com>
Date: Wed, 16 Jul 2008 13:13:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
CC: selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
References: <20080716165634.GA8072@hardeman.nu>
In-Reply-To: <20080716165634.GA8072@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Härdeman wrote:
> While working on SELinux-enabling a Debian system, I often Google for
> avc messages that show up in dmesg and 90% of the time it seems that the
> problem has already been solved in Fedora's version of the refpolicy but
> not in the upstream version.
> 
> Googling a bit more lead me to these emails:
> http://marc.info/?l=selinux&m=121155835630301&w=2
> http://marc.info/?l=selinux&m=121622105928866&w=2
> 
> The latest Fedora patch:
> http://cvs.fedoraproject.org/viewcvs/devel/selinux-policy/policy-20080710.patch?rev=1.2&view=auto
> 
> Is 36918 lines totalling over 1.1 Mb.
> 
> The latest Debian patch:
> http://ftp.de.debian.org/debian/pool/main/r/refpolicy/refpolicy_0.0.20080702-1.diff.gz
> 
> Is 8759 lines totalling 258Kb (but that includes the build scripts).
> 
> I wrote a quick python script that splits the Fedora patch into
> per-module patches (much like the ones Daniel J Walsh posted, only that
> I get 214 patches) and I'm prepared to start going over these patches
> seeing which ones are relevant and which ones would need some changes to
> work in Debian as well (for instance, lots of *.fc files would need to
> have lines like /etc/rc.d/init.d/something changed to
> /etc/(rc.d/)?init.d/something to work in both RH and Debian).
> 
> The question is how to treat the patches after that? Should I post them
> as I go through them (a couple per day for a couple of weeks?) and hope
> that someone at Tresys will apply them?
> 
> Also, Daniel, do you think it would be possible to change the Redhat
> build scripts to take a directory of patches instead of the huge patch
> it uses right now? It would make it much much easier to track the
> differences if the changes to each module was tracked in one patch in
> the CVS repo. It would also make it clearer what each change does (not
> at all clear sometimes with the current huge patch...comments and/or
> links to bugzilla entries would have been great) as each change to each
> patch will at least have the commit message to go along with it.
> 
> And in the end...does it really help? Someone at Tresys will have to
> review every patch anyway...so should I start looking at patches?
> 
My goal is to get more then just TreSys to check in patches.  Currently
we have a bottleneck that is not likely to be fixed.  This is not
anyone's fault, but we are not taking advantage of OpenSource and
allowing many hands/eyes to do this work.  Changing a module to user
auth_use_nsswitch when we realize it calls getpw*, should be easy to get
merged, and should not have a gatekeeper to prevent it.  If multiple
policy writers agree on the patch, it should just go in.  Now more
complicated changes like removing user prefix need to go much more slowly.

As far as my massive fix versus a 250 minor patches, is just a matter of
someone coming up with a better way.  I don't want to have 250 different
patches in the spec file.  Quilt has been suggested, but I am  not
familiar with it and am not sure how it work, nor do I have time to
implement it.

My current work habit is to take AVC messages from everywhere that I get
them. Bugzilla, Mail List, Chat Rooms, email, Personal Testing ...  And
modify my pool.  When I am done I run a big diff against refpolicy and
 update the patch.  So referencing all of the bugzilla's would only get
a snapshot of the fixes and would be very time consuming and dirty up
the patches.  Getting a quilt of different fixes for each day, I do not
believe would be of much use either since they are random.  Me
documenting each fix and sending it immediately upstream would not help,
since this would overwhelm me and upstream.

We are bringing on another dedicated policy writer in September,   who
could maybe help with verifying policy changes and getting them upstream.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh+LB4ACgkQrlYvE4MpobOHzACeMoNUCo46kxp5eOCaMOmRznMA
Gw4AoNy5Kp6rOcEDzcRDimbuyHlPqjdO
=MrXr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
