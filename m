Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KJuqrT020511
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 15:56:52 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KJtroq021182
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 19:55:54 GMT
Subject: Re: [PATCH] Gentoo-specific initrc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095688302.8397.132.camel@selinux>
References: <1095381586.735.30.camel@gorn.pebenito.net>
	 <200409191801.05094.russell@coker.com.au>
	 <1095599331.735.62.camel@gorn.pebenito.net>
	 <200409200704.46291.russell@coker.com.au>
	 <1095636681.735.70.camel@gorn.pebenito.net>
	 <1095688302.8397.132.camel@selinux>
Content-Type: text/plain
Message-Id: <1095710161.3225.12.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 15:56:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-09-20 at 09:51, Christopher J. PeBenito wrote:
> On Sun, 2004-09-19 at 19:31, Chris PeBenito wrote:
> > > What is the purpose of a etc_runtime_t directory?  Currently any process that 
> > > can create files as etc_runtime_t can write to a directory labelled as etc_t.  
> > 
> > Good point, I'll send an updated patch when sourceforge cvs starts
> > responding again for me.  I guess I got a little overzealous on the
> > labeling.
> 
> Here's the updated patch, against CVS.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
