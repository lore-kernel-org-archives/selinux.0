Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA07733
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 00:58:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0I5wFI13753
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 05:58:15 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h0I5wCf13749 for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 05:58:12 GMT
Date: Sat, 18 Jan 2003 16:57:53 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Cambridge Security Group talk
Message-ID: <20030118055753.GB26168@snoopy.apana.org.au>
References: <200301180149.27476.russell@coker.com.au> <20030118044554.A19790@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030118044554.A19790@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jan 18, 2003 at 04:45:55AM +0100, Tom wrote:
> One partial solution (for those of us using it) would be to make bash's
> "tab complete everything" feature aware of security contexts. It's
> already pretty powerful (e.g. on an scp it can tab-complete remote
> paths, for many programs it can tab-complete commandline parameters,
> etc)

On Debian (at leat Debian, probably any system), there is a directory,
/etc/bash_completion.d/ where packages can put scripts to enable
"non-standard" command line completion. It would appear to be very
powerful, and should be able to cope with any situation (I think).

It doesn't help me though, I use zsh...
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
