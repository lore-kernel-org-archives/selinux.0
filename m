Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KL7sWt023051
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:07:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KL7rmR000794
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:07:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9KL7qjp000791 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:07:52 GMT
Subject: Re: [Patch]  checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031020193259.GE3579@hydra.joerghoh.de>
References: <20031020193259.GE3579@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066684071.22196.413.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 17:07:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 15:32, Joerg Hoh wrote:
> - use unsigned int instead of unsigned long as bit specifier
> files: ebitmap.{c,h}

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
