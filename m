Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98DNNWt018845
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:23:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98DNM7d020385
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:23:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h98DNMRn020382 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:23:22 GMT
Subject: Re: 2.6.0-test6 boot process failures
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Chris PeBenito <pebenito@gentoo.org>, Tom <tom@lemuria.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200310081339.14251.russell@coker.com.au>
References: <20031007230348.E11325@lemuria.org>
	 <1065567176.2083.12.camel@chris.pebenito.net>
	 <200310081339.14251.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065619389.8181.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 09:23:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 23:39, Russell Coker wrote:
> Yes, this is a bug, and your analysis is correct.
> 
> Programs in /sbin or /bin must NEVER be linked against shared objects in
> /usr/lib .  As /bin/ps, /bin/ls, and /lib/security/pam_selinux.so are linked 
> against libselinux.so, libselinux.so should go into /lib.

Ok, I'll adjust the upstream Makefile accordingly, but Dan will need to
update the RPM spec file.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
