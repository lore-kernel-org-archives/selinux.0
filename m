Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i219hmRb025804
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 04:43:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i219hbQQ016326
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 09:43:37 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i219haP0016323 for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2004 09:43:37 GMT
Date: Mon, 1 Mar 2004 09:43:13 +0000
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   selinux@tycho.nsa.gov
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Message-ID: <20040301094313.GB4168@vnl.com>
References: <20040228181418.GO11147@vnl.com> <200402291344.28017.russell@coker.com.au> <20040229042610.GA11147@vnl.com> <200402291545.38528.russell@coker.com.au> <20040229160106.GH24151@vnl.com> <1078117604.397.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078117604.397.6.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 01, 2004 at 12:06:45AM -0500, Colin Walters wrote:
> > After Colin's install script removes klogd.te, the policy build fails:
> 
> Are you using my very old selinux-policy-default package?  You must be,
> since Russell hasn't yet merged the smarter installation script into his
> packages.  Anyways at this point, I strongly suggest using Russell's
> policy packages.  Hopefully soon we'll get that script merged in.

I have to have your script to do what I'm doing. It's
not an issue of 'just instaling' selinux. I can do that.
It's the hands-off build I've been fiddling with for
some time. 

I've got a workaround for now, I just replace klogd.te after
the install 'Automatic' removes it. If you'd let me know when
the merge with your script occurs, I'd appreciate that greatly
as then I can back out the hacks I'm using and perhaps switch
entirely to Russ's repository.

Just so you know, this is what I have to do at present
to get a workable set for a hands-off build:

sources.list
--------------------
deb http://www.coker.com.au/newselinux/ ./
deb http://web.verbum.org/debian/ ./experimental/
deb http://ftp.nl.debian.org/debian/ sid main non-free contrib
deb http://ftp.nl.debian.org/debian-non-US sid/non-US main contrib non-free

preferences
--------------------
Package: *
Pin: release l=etbe
Pin-Priority: 1200

Package: *
Pin: release o=walters
Pin-Priority: 1100
 
If you or Russ think the problems are sorted, I'd be
happy to have a go at building entirely off his repository.
Note that I've not gotten around to switching over from
initrd to svinit boot procedures though. I'm doing this
as a background task as I'm quite busy with a job
right now. I just start up a test run of my autobuild
and go do real work for the next hour or two :-)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
