Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA21581
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 13:37:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA01828
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:35:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA01823
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:35:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Date: Tue, 29 Oct 2002 19:37:10 +0100
References: <20021029173606.A28387@lemuria.org> <Pine.GSO.4.33.0210291146020.29605-100000@raven> <20021029184539.A16049@lemuria.org>
In-Reply-To: <20021029184539.A16049@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210291937.10550.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Oct 2002 18:45, Tom wrote:
> On Tue, Oct 29, 2002 at 12:09:30PM -0500, Stephen Smalley wrote:
> > > The main reason for giving the client tools a domain was to unify
> > > server and client access, i.e. set up the repository so that it can
> > > only be accessed by the proper tools. As with CVS, tampering directly
> > > with the repository will corrupt it.
> >
> > It would offer some limited integrity protection in terms of ensuring
> > that the transactions on the repository are well-formed (i.e. only
> > permitting transactions implemented via svn, svnlock, or svnadmin
> > commands).  But it
>
> Correct. It protects from mistakes, not malicious intent.
>
> I still see the value in it, especially given that Subversion is still
> in development - who knows what kinds of access controls and other fine
> print the team might still add? Running in its own domain, the policy
> is ready for whatever they come up with.

I suggest that you contact the Subversion developers and ask their opinion on 
what the security policy should be.  Of course we won't necessarily accept 
what they say, but it will be useful to get some input from them.

> Also, I may think about restricting _local_ access for these tools,
> because they are connecting outwards to potentially hacked and/or
> malicious servers.

True.  Of course if you download, compile, and run code from a potentially 
hacked server then an exploit of a Subversion bug is the least of your 
worries...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
