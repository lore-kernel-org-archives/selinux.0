Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LCBkWt025859
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 08:11:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LCBjmR020988
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:11:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9LCBjjp020985 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:11:45 GMT
Subject: Re: [Patch] checkpolicy (3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031020212056.GF3579@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 08:11:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 17:20, Joerg Hoh wrote:
> - fix calls to fwrite (size_t instead of int)
> file: write.c

Why?  In particular, what possible point is there in casting constant
size values (e.g. 3) to size_t?  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
