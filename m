Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ABGSWt002147
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 07:16:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ABGRUb029981
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:16:27 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9ABGQhX029961 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:16:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: newrules.pl -o option
Date: Fri, 10 Oct 2003 21:16:16 +1000
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp> <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp> <20031010082834.GA31227@vnl.com>
In-Reply-To: <20031010082834.GA31227@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310102116.16958.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 18:28, Dale Amon wrote:
> Which also brings up the point, what is the most
> appropriate place for it to install? Would it be
> wise for it to be useable during early boot, thus in
> /sbin, or just later in /usr/sbin? Or should it be
> considered a user tool and be in /bin or /sbin?

It should be in /usr/bin.  sbin is the wrong place as it does not require any 
administrative access for full operation, scp'ing log files from a machine 
where you are administrator to another machine where you are only a user for 
analysis is reasonable and expected.  /bin is the wrong place as it is not 
required for system boot (and I could not imagine how it would be required), 
also on many (most?) systems Perl is under /usr so it can't be used before /
usr is mounted anyway.

Also "newrules" is not a good choice of name.  There are potentially hundreds 
of things on a Unix system that have rules and which may have new rules 
generated.  On Debian systems it is currently /usr/bin/newrules-selinux, I 
think that's an ideal name for it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
