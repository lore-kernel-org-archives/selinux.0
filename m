Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA09907
	for <selinux@tycho.nsa.gov>; Sun, 31 Dec 2000 08:30:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id NAA00709
	for <selinux@tycho.nsa.gov>; Sun, 31 Dec 2000 13:29:39 GMT
Received: from Allen.fw.matav.hu (matav-2.matav.hu [145.236.241.99])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id NAA00705
	for <selinux@tycho.nsa.gov>; Sun, 31 Dec 2000 13:29:38 GMT
Received: from mag by bunuel.tii.matav.hu with local (Exim 3.11 #1 (Debian))
	id 14CiYl-0005ZT-00
	for <selinux@tycho.nsa.gov>; Sun, 31 Dec 2000 14:30:03 +0100
Date: Sun, 31 Dec 2000 14:30:03 +0100
From: =?iso-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: selinux@tycho.nsa.gov
Subject: Re: [selinux] subject prefix?
Message-ID: <20001231143003.A21414@bunuel.tii.matav.hu>
References: <20001231124516.BCA963491@Galois.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20001231124516.BCA963491@Galois.suse.de>; from marc@suse.de on Sun, Dec 31, 2000 at 01:45:16PM +0100
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

A levelezõm azt hiszi, hogy Marc Heuse a következõeket írta:
> 
> sorry for an administrivia question:
> 
> would it be possible to add a sbject like "[SeLinux] " in front of every
> subject by the mailinglist software? I guess all people here are on many
> mailinglists and not all of them use procmail etc. to automatically move
> mails to folders so this would make threading and the general mailbox
> overview better.
> 

my .procmailrc reads:

:0 cf
* ^Sender:.*owner-selinux@tycho.nsa.gov
|sed 's/^Subject:\(.*\)/Subject: [selinux]\1/'

-- 
GNU GPL: csak tiszta forrásból
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
