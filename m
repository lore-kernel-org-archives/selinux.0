Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FMlCL9012185
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 17:47:12 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FMhiw0001806
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 22:43:44 GMT
Date: Tue, 15 Feb 2005 22:56:04 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20050215225604.GA29523@lkcl.net>
References: <20050215213455.GF26294@lkcl.net> <421275E0.9060509@trustedcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421275E0.9060509@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 15, 2005 at 04:21:20PM -0600, Darrel Goeddel wrote:
> Luke Kenneth Casson Leighton wrote:
> >stephen,
> >
> >i assume it _is_ necessary to perform dynamic auto transitions?
> >
> >such that i can track to alternative contexts, yes?
> >
> 
> Could you explain what you mean by "dynamic auto transitions"?  An auto 
> transition is a policy defined transition upon exec.  The dynamic 
> transitions (setcon) are done programatically.
 
 yes, and they're absolutely awful.
 
 as explained in a message which has crossed with this one
 and outlines some pseudo-code in which a security context is
 HARD-CODED into the program.

 plus a patch which _implements_ "dynamic auto transitions".

 so i'm hoping that my other message will cover this question,
 which you should receive in the next few mins.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
