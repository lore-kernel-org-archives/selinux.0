Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23637
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 18:22:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA14378
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 22:21:09 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id WAA14374 for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 22:21:07 GMT
Date: Fri, 16 Aug 2002 08:22:37 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy file management
Message-ID: <20020815222237.GA26062@snoopy.apana.org.au>
References: <20020815180940.3719C854@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020815180940.3719C854@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 15, 2002 at 08:09:39PM +0200, Russell Coker wrote:
> So postfix.te depends on mta.te (it won't be offered if you don't have 
> mta.te), it conflicts with other mail-server policy (IE qmail.te and 
> sendmail.te).
> 
> What do you think?

What tool do you propose would parse these headers?

Would you have a tool for installing policies according to these rules,
or would you simply check the installed policy before compiling it?

Anyway, for my conference submission for LCA (not yet accepted), I
have designed a new XML file format which defines a formal unit called
a "package". This might be another solution, as each package defines
domains in its own name space. It would also allow installing several
different MTAs for instance, with different port numbers or something
(although don't ask me why you would want to do that...).

Of course, there is still some work to do, for instance, which label
from which package to use to label what files with. I need to think
about this one.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
