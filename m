Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LJxHWt029726
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 15:59:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LJxFIE016859
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 19:59:15 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h9LJxE1J016853 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 19:59:15 GMT
Date: Tue, 21 Oct 2003 21:59:47 +0200
From: Joerg Hoh <joerg@devone.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: [Patch] checkpolicy (3)
Message-ID: <20031021195947.GB3638@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de> <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil> <20031021154814.GA3638@hydra.joerghoh.de> <1066762919.27065.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066762919.27065.207.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2003 at 03:01:59PM -0400, Stephen Smalley wrote:
> On Tue, 2003-10-21 at 11:48, Joerg Hoh wrote:
> > Constant values are ints. man 3 fwrite states on my system:
> > 
> > size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
> > 
> > int is always 32bit, even when size_t is 64bit.
> 
> Type conversion should be automatic in this case, no explicit cast
> required.  At most, you might want to qualify the constant in some
> manner, e.g. 3UL, but I'm not sure whether even that is justified.

The gcc on my alpha produces warnings, so there is no implicit conversion.
We should make it explicit. 

I prefer the cast via "(size_t)" over "3z", because most people probably
don't know, what that "z" means (it's the qualifier for size_t and
ssize_t).

Joerg


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
