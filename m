Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LJ23Wt029323
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 15:02:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LJ1oIS021748
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 19:01:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9LJ1oDc021743
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 19:01:50 GMT
Subject: Re: [Patch] checkpolicy (3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031021154814.GA3638@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de>
	 <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil>
	 <20031021154814.GA3638@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066762919.27065.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 15:01:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 11:48, Joerg Hoh wrote:
> Constant values are ints. man 3 fwrite states on my system:
> 
> size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
> 
> int is always 32bit, even when size_t is 64bit.

Type conversion should be automatic in this case, no explicit cast
required.  At most, you might want to qualify the constant in some
manner, e.g. 3UL, but I'm not sure whether even that is justified.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
