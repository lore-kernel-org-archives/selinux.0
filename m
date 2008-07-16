Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GGuaUE018665
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 12:56:36 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GGuZCD008518
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 16:56:36 GMT
Date: Wed, 16 Jul 2008 18:56:34 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Subject: Fedora refpolicy patches
Message-ID: <20080716165634.GA8072@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While working on SELinux-enabling a Debian system, I often Google for 
avc messages that show up in dmesg and 90% of the time it seems that the 
problem has already been solved in Fedora's version of the refpolicy but 
not in the upstream version.

Googling a bit more lead me to these emails:
http://marc.info/?l=selinux&m=121155835630301&w=2
http://marc.info/?l=selinux&m=121622105928866&w=2

The latest Fedora patch:
http://cvs.fedoraproject.org/viewcvs/devel/selinux-policy/policy-20080710.patch?rev=1.2&view=auto
Is 36918 lines totalling over 1.1 Mb.

The latest Debian patch:
http://ftp.de.debian.org/debian/pool/main/r/refpolicy/refpolicy_0.0.20080702-1.diff.gz
Is 8759 lines totalling 258Kb (but that includes the build scripts).

I wrote a quick python script that splits the Fedora patch into 
per-module patches (much like the ones Daniel J Walsh posted, only that 
I get 214 patches) and I'm prepared to start going over these patches 
seeing which ones are relevant and which ones would need some changes to 
work in Debian as well (for instance, lots of *.fc files would need to 
have lines like /etc/rc.d/init.d/something changed to 
/etc/(rc.d/)?init.d/something to work in both RH and Debian).

The question is how to treat the patches after that? Should I post them 
as I go through them (a couple per day for a couple of weeks?) and hope 
that someone at Tresys will apply them?

Also, Daniel, do you think it would be possible to change the Redhat 
build scripts to take a directory of patches instead of the huge patch 
it uses right now? It would make it much much easier to track the 
differences if the changes to each module was tracked in one patch in 
the CVS repo. It would also make it clearer what each change does (not 
at all clear sometimes with the current huge patch...comments and/or 
links to bugzilla entries would have been great) as each change to each 
patch will at least have the commit message to go along with it.

And in the end...does it really help? Someone at Tresys will have to 
review every patch anyway...so should I start looking at patches?

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
