Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OK68FX028995
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:06:09 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OK41uq018480
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 20:04:01 GMT
Subject: Re: Man pages added to policy file.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Karsten Wade <kwade@redhat.com>
In-Reply-To: <41F03552.90806@redhat.com>
References: <41F03552.90806@redhat.com>
Content-Type: text/plain
Message-Id: <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 15:02:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged man pages and other stuff not previously merged (except the
mozilla execmem rule) into the sourceforge CVS repository.

On Thu, 2005-01-20 at 17:48, Daniel J Walsh wrote:
> I am adding these man pages to the policy file to attempt to describe 
> how users might manipulate policy.
> 
> The goal was to describe Booleans and File Context that a user might 
> want to manipulate.  Please review the man pages.
> (IE translate them from dwalsh to English :^) )
> 
> I also attached the latest policy file that includes all changes 
> including the previous patch I submitted.  The main new stuff
> is around trying to get telnet, rlogin, and rshd to work.  We pretty 
> much figured out that SELinux is not going to offer much
> protection with targeted policy since these apps need to either 
> transition directly to unconfined_t or to transition to login which
> will transition to unconfined_t.
> 
> Looks like we will need to split up the apps via Priv-Separation in 
> order to make this of much use.
> 
> Dan

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
