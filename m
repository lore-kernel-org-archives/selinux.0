Subject: Re: changes in ~2.6.13 break postfix policy?
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
	 <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 05 Nov 2005 00:53:26 +0100
Message-Id: <1131148407.1355.21.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> Linus' -git tree for 2.6.15.  Where might one be able to obtain the
> patches included in the Debian kernel?  Any direct use of sock_alloc()

http://packages.debian.org/linux-image-2.6.14-1-686-smp
is the kernel I'm using. There is a link to the sourcecode.
All the linux-2.6 packages are built from the same codebase, so the
download for the source package is
http://ftp.debian.org/debian/pool/main/l/linux-2.6/linux-2.6_2.6.14.orig.tar.gz
http://ftp.debian.org/debian/pool/main/l/linux-2.6/linux-2.6_2.6.14-2.diff.gz
(or any other debian mirror)

With debian packages, the .orig.tar.gz file usually contains the
upstream provided source code unmodified (if possible by licence
restrictions, ocassionally single files have to be remove due to
licencing issues)
and the debian specific changes are in the .diff.gz file.

I did a quick search in the .diff.gz for "sock_", 0 matches; but I
didn't check the .orig.tar.gz file.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     You know we all became mathematicians for the same reason:     //\
                  we were lazy. --- Max Rosenlicht                  V_/_
   Jede Frau erwartet von einem Mann, dass er hält, was sie sich
                         von ihm verspricht.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
