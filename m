Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AJ6dY5031247
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 15:06:39 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2AJ6b0u012181
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 19:06:38 GMT
Subject: Re: [DSE-Dev] Refpolicy quilt series for Debian
From: Erich Schubert <erich@debian.org>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        selinux-devel@lists.alioth.debian.org
In-Reply-To: <47D57913.2080809@martinorr.name>
References: <47D57913.2080809@martinorr.name>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 20:06:08 +0100
Message-Id: <1205175968.5002.96.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Martin,
Thanks for your work.

> I have published the patches I am using to reference policy, on Debian sid.
>  This includes all the patches from Manoj's official Debian package, split
> out into a quilt series.

There is also a policy tree in Debian SVN which might contain some more
changes I did for my packages. Not all of that was merged into Manojs
package, I believe. I don't have an overview of which of my changes were
merged by Manoj. Some of them might also no longer be required.

You can browse the tree here
http://svn.debian.org/wsvn/selinux/refpolicy/branches/debian/?rev=0&sc=0
SVN urls etc. are listed on svn.debian.org

There is also a packaged version:
 http://selinux.alioth.debian.org/experimental/refpolicy/
(strict and targeted are already merged in that version, but it is
totally untested.)

Keep up the good work. It's nice to see the increased interest in Debian
SELinux and all the recent contributions!

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                Friends are those who reach out for                 //\
                  your hand but touch your heart.                   V_/_
            Es lohnt sich nicht, die Augen aufzumachen,
                   wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
