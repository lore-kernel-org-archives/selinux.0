Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PHxLLa026158
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 13:59:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7PHvs4F017025
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 17:57:54 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id h7PHvsFC017022
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 17:57:54 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PHxIdu020264
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 13:59:19 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7PHxIZJ020262
	for selinux@tycho.nsa.gov; Mon, 25 Aug 2003 13:59:18 -0400
Date: Mon, 25 Aug 2003 18:52:49 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   Brian May <bam@snoopy.apana.org.au>, SELinux@tycho.nsa.gov
Subject: Re: 2.6.0-test3
Message-ID: <20030825175249.GA21706@vnl.com>
References: <200308212337.59952.russell@coker.com.au> <1061487623.22355.27.camel@columbia> <20030821223223.GA20695@snoopy.apana.org.au> <200308222244.46282.russell@coker.com.au> <20030824173055.GA21382@vnl.com> <1061747454.12939.216.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1061747454.12939.216.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 24, 2003 at 01:50:54PM -0400, Colin Walters wrote:
> On Sun, 2003-08-24 at 13:30, Dale Amon wrote:
> > On Fri, Aug 22, 2003 at 10:44:46PM +1000, Russell Coker wrote:
> > > On Fri, 22 Aug 2003 08:32, Brian May wrote:
> > > > Does the libselinux in unstable support the 2.6 interface yet?
> > > 
> > > Colin is about to upload a new libselinux for 2.6 and the 2.4 back-port...
> > 
> > Any ETA for when the updates be available? I'm still seeing 
> > the conflict with the selinux package and policycoreutils.
> 
> I think this is due to the incompatibilities with Russell's
> selinux-policy-default.  I split out policycoreutils from that package.

Could some one give me a heads up when I should try a sid update
to sort my test machine out? It's very confused at the moment! :-)

No terrible rush, just tell me when things are sorted.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
