Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CLjm2j016083
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 17:45:48 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5CLjlOt019607
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 21:45:47 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1150148356.18657.32.camel@sgc>
References: <448DC130.4010309@redhat.com>  <1150148356.18657.32.camel@sgc>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 17:47:18 -0400
Message-Id: <1150148838.18657.36.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-12 at 17:39 -0400, Christopher J. PeBenito wrote:
> On Mon, 2006-06-12 at 15:32 -0400, Daniel J Walsh wrote:
> > hplib is communicating with nfs somehow.
> 
> Interesting, I always thought this access (which was in can_network())
> was a leaked fd.  If possible, can you find out more?  Moved the add up
> a few lines in the file.

Actually, I think you just accidentally reverted my change, considering
there were other reversions later in the patch.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
