Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23686
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 18:28:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA14683
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 22:26:35 GMT
Received: from ivanova.coker.com.au (ivanova.coker.com.au [203.36.46.209])
	by jazzswing.ncsc.mil  with ESMTP id WAA14678
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 22:26:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        "John S. Gage" <jgage@epo.som.sunysb.edu>
Subject: Re: Debian distribution of selinux
Date: Thu, 4 Oct 2001 00:11:58 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0110021511290.14371-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0110021511290.14371-100000@raven>
MIME-Version: 1.0
Message-Id: <20011003222642.D78C0329539@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Oct 2001 21:20, Stephen Smalley wrote:
> On Tue, 2 Oct 2001, John S. Gage wrote:
> > Is selinux going to be made into a Debian distribution?  That would be a
> > good thing.
>
> There seems to be some interest by some of the Debian developers in
> creating a SELinux package for the Debian distribution, as evidenced by
> the recent email by Manoj Srivastava and Russell Coker on the selinux
> list.  See the current mailing list archives (available via email to
> majordomo@tycho.nsa.gov or online at
> http://marc.theaimsgroup.com/?l=selinux).
>
> I agree that this would be a good thing, and we are trying to be helpful.
> However, it will take a certain amount of work, even aside from packaging
> issues, since the example policy and the modified daemons and utilities
> were based on a RedHat distribution.

I don't anticipate getting this done in time for the release of woody.  :(

I plan to get everything in unstable after woody is released and then create 
an archive for back-ports to woody.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
