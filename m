Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98GCqWt020298
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:12:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98GCq6g000549
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 16:12:52 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h98GCodq000546 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 16:12:51 GMT
Subject: Re: 2.6.0-test6 boot process failures
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1065619598.8181.102.camel@moss-spartans.epoch.ncsc.mil>
References: <20031007230348.E11325@lemuria.org>
	 <1065567176.2083.12.camel@chris.pebenito.net>
	 <1065619598.8181.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1065629569.4979.114.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Wed, 08 Oct 2003 11:12:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-08 at 08:26, Stephen Smalley wrote:
> On Tue, 2003-10-07 at 18:52, Chris PeBenito wrote:
> > On a side note, I noticed that all of the coreutils programs were
> > mysteriously linked against libselinux for some reason (as reported by
> > ldd).  I don't know yet why this is happening.  Is this happening to
> > other people's systems?
> 
> Sorry, why is this surprising given the coreutils selinux patch?
> Or do you mean that even coreutils programs that aren't patched for
> SELinux are also showing up with dependencies on libselinux?  
> The coreutil-selinux.patch does add -lselinux to the LDADD line in
> the Makefile.

Every single binary.  Even the ones that aren't patched, such as uname
and yes.  See the attached ldd outputs.  This happens on both my x86 and
PPC.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
