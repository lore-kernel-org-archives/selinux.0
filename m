Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA11579
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 02:18:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA27480
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 06:16:34 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id GAA27476
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 06:16:32 GMT
Date: Wed, 2 Oct 2002 16:17:52 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: Tracy R Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002061752.GA17703@snoopy.apana.org.au>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021002074201.C28663@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 02, 2002 at 07:42:01AM +0200, Tom wrote:
> you need to delete two files:
> 
> /etc/selinux/domains/program/run_deb.te
> /etc/selinux/domains/program/run_init.te
> 
> their content was moved into other files, so they are not needed
> anymore now and result in the above conflict

This problem should be fixed in the latest version of my package...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
