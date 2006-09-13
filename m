Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DMFEtc012513
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 18:15:17 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DMENib022912
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 22:14:23 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 230FAC4C088
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 00:15:14 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 01571-06 for <selinux@tycho.nsa.gov>;
	Thu, 14 Sep 2006 00:15:13 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A4DF1.dip.t-dialin.net [84.154.77.241])
	by legolas.drinsama.de (Postfix) with ESMTP id D4B83C4C083
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 00:15:12 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id CA41D234017
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 00:15:10 +0200 (CEST)
Subject: awk, isatty(), libc and ioctl()
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 14 Sep 2006 00:15:10 +0200
Message-Id: <1158185710.1594.94.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
one of the few audit errors remaining on my test box is
  initrc_t postfix_etc_t:file ioctl;

Which sounds like an odd behaviour to me. I've tracked it down to the
init script using an awk-one-liner to determine if it needs to sync the
chroot.
Awk however calls isatty() on any file it processes. Which is
implemented in the libc apparently using an ioctl TCGETS; this will fail
for regular files.

So should I add a "dontaudit" for this behaviour (but it will resurface
again whenever awk is used in a script!) or maybe find a workaround for
isatty()?
Awk (or isatty()) could probably use fstat(), too. Anyone deep enough in
kernel interfaces to comment on that? Any chance of modifying the LSM
hooks to not audit this type of behaviour (calling unsupported ioctls)?
Or anything?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
      The future is here. It's just not evenly distributed yet.     //\
   Es ist beschämender seinen Freunden zu mißtrauen als von ihnen   V_/_
        getäuscht zu werden. --- François de la Rochefoucauld



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
