Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98DQlWt018877
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:26:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98DQk7d020515
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:26:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h98DQkRn020512 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:26:46 GMT
Subject: Re: 2.6.0-test6 boot process failures
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1065567176.2083.12.camel@chris.pebenito.net>
References: <20031007230348.E11325@lemuria.org>
	 <1065567176.2083.12.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1065619598.8181.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 09:26:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 18:52, Chris PeBenito wrote:
> On a side note, I noticed that all of the coreutils programs were
> mysteriously linked against libselinux for some reason (as reported by
> ldd).  I don't know yet why this is happening.  Is this happening to
> other people's systems?

Sorry, why is this surprising given the coreutils selinux patch?
Or do you mean that even coreutils programs that aren't patched for
SELinux are also showing up with dependencies on libselinux?  
The coreutil-selinux.patch does add -lselinux to the LDADD line in
the Makefile.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
