Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8GCdcAn025221
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 08:39:38 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8GCdAdN000853
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 12:39:10 GMT
Subject: Re: awk, isatty(), libc and ioctl()
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200609162208.13198.russell@coker.com.au>
References: <1158185710.1594.94.camel@wintermute.xmldesign.de>
	 <200609162208.13198.russell@coker.com.au>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 14:37:16 +0200
Message-Id: <1158410236.10929.8.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russel,
> One thing to note is that Perl has the same issue in regard to ioctl() on all 
> files.

What can ioctl() on *regular* files do?
The "ioctl" manpage just mentions "special files".

I mean... we'll probably have to add ioctl dontaudits for so many
domains, we might want to go with something like
"dontaudit domain file_type:file ioctl;"
at least for any user domain (I mean, most admins will allow their users
to use awk or perl in one way or another).

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     You know we all became mathematicians for the same reason:     //\
                  we were lazy. --- Max Rosenlicht                  V_/_
       Wenn Leute nicht glauben, dass Mathematik einfach ist,
            dann nur deshalb, weil sie nicht begreifen,
        wie kompliziert das Leben ist. --- John von Neumann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
