Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA09706
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 06:50:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA26570
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 10:47:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA26566
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 10:47:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: checkpolicy and login names
Date: Wed, 25 Sep 2002 12:49:00 +0200
References: <GBEAJBKHFOBIBBJBCGAGKEKGCFAA.dac@tresys.com> <200209241900.20427.russell@coker.com.au> <20020925092730.GB17419@snoopy.apana.org.au>
In-Reply-To: <20020925092730.GB17419@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209251249.00585.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Sep 2002 11:27, Brian May wrote:
> On Tue, Sep 24, 2002 at 07:00:20PM +0200, Russell Coker wrote:
> > On Tue, 24 Sep 2002 16:32, david caplan wrote:
> > > We just ran across the case where we were trying to add a login name
> > > with a '.' in it.  When we tried to add the user to the policy,
> > > checkpolicy choked on the '.' in the id.  The parser expects an
> > > Identifier, which is defined to be a letter followed by a combination
> > > of letter|digit|_ of any length.
> >
> > What about "chown user.group file"?  I think that alone is a good enough
> > reason not to want to have a '.' in a user-name.
>
> ns has a number of userids with '.' in them.
>
> Required for cgi-wrap I think.

Oh yes, I forgot about that.  If you want to have a DNS domain name as a Unix 
account name (needed for cgiwrap and some other wrapper programs for cgi-bin 
scripts) then you need the dots.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
