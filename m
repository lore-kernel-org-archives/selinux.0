Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA03399
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 23:51:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA19934
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 03:49:36 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA19924 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 03:49:34 GMT
Date: Tue, 13 Aug 2002 13:51:03 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: Re: Swollen su_macros.te file
Message-ID: <20020813035103.GA22164@snoopy.apana.org.au>
References: <20020812222957.674718732@lyta.coker.com.au> <20020813002617.72875.qmail@web40008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020813002617.72875.qmail@web40008.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 12, 2002 at 05:26:17PM -0700, Brad Chapman wrote:
> > This means that su is operating correctly on your system.
> 
>         Um.... OK. Could you explain that?

su is not meant to change your context, and in your case it isn't.

That is good.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
