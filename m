Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAE4hSf003682
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 09:04:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAAE4bKl001684
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:04:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAAE4a5m001679 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:04:36 GMT
Subject: Re: stripped static binaries
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311091638.15350.carstengrohmann@gmx.de>
References: <200311091638.15350.carstengrohmann@gmx.de>
Content-Type: text/plain
Message-Id: <1068473072.32532.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 Nov 2003 09:04:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-09 at 10:38, Carsten Grohmann wrote:
> I think, we should strip the static binaries like load_policy. Thru 
> this we could save space in the initrd. The patch for the 
> policycoreutils is attached.
> 
> What do you think about it?

With Dan's patched init program, it is not necessary to perform the load
from an initrd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
