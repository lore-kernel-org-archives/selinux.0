Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AEefWt003685
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 10:40:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9AEeb0p025066
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 14:40:37 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9AEeZr7025058
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 14:40:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: newrules.pl -o option
Date: Sat, 11 Oct 2003 00:40:30 +1000
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp> <200310102116.16958.russell@coker.com.au> <1065793227.8181.426.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065793227.8181.426.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310110040.30023.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 23:40, Stephen Smalley wrote:
> On Fri, 2003-10-10 at 07:16, Russell Coker wrote:
> > Also "newrules" is not a good choice of name.  There are potentially
> > hundreds of things on a Unix system that have rules and which may have
> > new rules generated.  On Debian systems it is currently
> > /usr/bin/newrules-selinux, I think that's an ideal name for it.
>
> Not clear you need a '-selinux' suffix for SELinux-related programs; we
> certainly haven't done that for other SELinux utilities (e.g.
> checkpolicy, load_policy).  Other possible names might be:
> 	genpol (generate policy)
> 	audit2allow (convert audit messages to allow rules)

audit2allow is a clearer explanation of what the program does, and is also 
less likely to be ambiguous.  I think that /usr/bin/audit2allow is a 
reasonable name.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
