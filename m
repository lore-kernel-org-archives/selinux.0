Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3O3BZI4006276
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 23:11:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3O3BY7R006122
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:11:34 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3O3BVKP006119 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:11:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dave Dodge <dododge@alpha.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: portability patch for char signedness
Date: Thu, 24 Apr 2003 13:11:25 +1000
References: <200304141459.54596.russell@coker.com.au> <20030423180107.79a79184.dododge@alpha.ncsc.mil>
In-Reply-To: <20030423180107.79a79184.dododge@alpha.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304241311.25169.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Apr 2003 08:01, Dave Dodge wrote:
> > The attached patch fixes some char signedness issues.
> >
> > -  char c;
> > +  int c_int;
> >
> > -  while ( (c = getopt(argc, argv, "k:c:s:")) != EOF) {
> > -    switch (c) {
> > +  while ( (c_int = getopt(argc, argv, "k:c:s:")) != EOF) {
> > +    switch ((char)c_int) {
>
> A slightly simpler fix is to just change the type of "c" to int
> without renaming or casting. "getopt" returns an int, all of
> the case statements are ints, and "c" is not used in any other
> context.

True.  However single character variable names are often an annoyance to 
programmers.  The traditional variables i, j, and maybe k for loops are 
generally accepted, but otherwise it's generally considered to be a good idea 
to have a longer name that can be searched for more easily.  With the name 
c_int you can just type "/c_int" in vi to find the next use of it, while "/c" 
will return lots of matches that you don't want.

It took me a few extra seconds to review every file I was patching because of 
this, so I decided that it would be good to change the variable name and save 
the next programmer the effort.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
