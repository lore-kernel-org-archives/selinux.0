Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LFlhWt027541
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 11:47:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LFlhIE002040
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 15:47:43 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h9LFlg1J002035 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 15:47:42 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 43ED9170021
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:01:53 +0200 (CEST)
Date: Tue, 21 Oct 2003 17:48:14 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: [Patch] checkpolicy (3)
Message-ID: <20031021154814.GA3638@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de> <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2003 at 08:11:37AM -0400, Stephen Smalley wrote:
> On Mon, 2003-10-20 at 17:20, Joerg Hoh wrote:
> > - fix calls to fwrite (size_t instead of int)
> > file: write.c
> 
> Why?  In particular, what possible point is there in casting constant
> size values (e.g. 3) to size_t?  

Constant values are ints. man 3 fwrite states on my system:

size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);

int is always 32bit, even when size_t is 64bit.

Joerg


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
