Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HLwlRb027455
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 17:58:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4HLwjAR015270
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:58:45 GMT
Received: from hafnium.btinternet.com (hafnium.btinternet.com [194.73.73.121])
        by jazzband.ncsc.mil  with ESMTP id i4HLwiHn015267 for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:58:44 GMT
Date: Mon, 17 May 2004 21:56:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Message-ID: <20040517215601.GW9378@lkcl.net>
References: <20040515232606.GA9378@lkcl.net> <200405180510.40047.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405180510.40047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 05:10:40AM +1000, Russell Coker wrote:
> On Sun, 16 May 2004 09:26, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > and i presume that if such programs are compromised, and someone
> > attempts to _stop_ libselinux from being loaded, well then
> > those programs will not be capable of making domain transitions
> > etc. and they will be useless [am i right?]
> 
> The first candidate for such changes would be init.  We would have to 
> hard-code a check for selinux=0 in the init source to avoid having init just 
> not enable SE Linux if file system corruption causes libselinux.so to 
> disappear.
 
 oh.  eek!  of course :)  cause libselinux.so to be corrupted and you're
 in.

 hmmm.... physical security is assumed already (i.e. no boot from
 floppy)... 

 ... modification of initscripts "by corruption" an outside chance...
 
 ... replacement of initscripts (apt-get install sysvinit) _cannot_
 be ruled out...

 ... therefore the startup process must be secure (no dynamic loading)

 i don't know enough to be able to say it would be good, or bad, to
 make _some_ programs do dynamic loading of libselinux and some not
 do it.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
