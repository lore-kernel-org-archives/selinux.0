Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PBmJLa023220
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 07:48:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7PBkq4F003716
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 11:46:52 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
	by jazzswing.ncsc.mil  with ESMTP id h7PBkqFC003713
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 11:46:52 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PBmIsE003709
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 07:48:18 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7PBmIIw003707
	for selinux@tycho.nsa.gov; Mon, 25 Aug 2003 07:48:18 -0400
Subject: Re: 2.6.0-test3
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>,
   SELinux@tycho.nsa.gov
In-Reply-To: <20030824173055.GA21382@vnl.com>
References: <200308212337.59952.russell@coker.com.au>
	 <1061487623.22355.27.camel@columbia>
	 <20030821223223.GA20695@snoopy.apana.org.au>
	 <200308222244.46282.russell@coker.com.au>  <20030824173055.GA21382@vnl.com>
Content-Type: text/plain
Message-Id: <1061747454.12939.216.camel@columbia>
Mime-Version: 1.0
Date: Sun, 24 Aug 2003 13:50:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-08-24 at 13:30, Dale Amon wrote:
> On Fri, Aug 22, 2003 at 10:44:46PM +1000, Russell Coker wrote:
> > On Fri, 22 Aug 2003 08:32, Brian May wrote:
> > > Does the libselinux in unstable support the 2.6 interface yet?
> > 
> > Colin is about to upload a new libselinux for 2.6 and the 2.4 back-port...
> 
> Any ETA for when the updates be available? I'm still seeing 
> the conflict with the selinux package and policycoreutils.

I think this is due to the incompatibilities with Russell's
selinux-policy-default.  I split out policycoreutils from that package.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
