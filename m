Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAULKHRb003820
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 16:20:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAULKGqY017467
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:20:16 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAULKG0o017464 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:20:16 GMT
Date: Sun, 30 Nov 2003 21:20:08 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031130212008.GD11972@vnl.com>
References: <20031129123120.GI18062@vnl.com> <20031130143606.GC11972@vnl.com> <200312010710.09197.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312010710.09197.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 07:10:09AM +1100, Russell Coker wrote:
> On Mon, 1 Dec 2003 01:36, Dale Amon <amon@vnl.com> wrote:
> > rm postinst.d/selinux in my script at that point so
> > that package installation doesn't get broken, but
> > sweeping things under the rug is hardly ever a good
> > idea.
> 
> I don't sweep things under the rug.

Russ, that's not what I said. I said that me doing it in
my script is sweeping it under the rug. 
 
> Building Debian packages is not difficult.  Getting the source to a package 
> and modifying it to work the way you want should be easy enough.

Certainly, if I was only doing this for a one time install
or just for myself. I'm trying to beat on them to 
show up the problems so that someone else who can't sort
in on their own doesn't have to.

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
