Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IBlHRb000556
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 07:47:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IBlFAR013310
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:47:15 GMT
Received: from rhenium.btinternet.com (rhenium.btinternet.com [194.73.73.93])
        by jazzband.ncsc.mil  with ESMTP id i4IBlEHn013307 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:47:14 GMT
Date: Tue, 18 May 2004 11:44:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Les Bell <lesbell@lesbell.com.au>
Cc: Chris Babcock <cbabcock@luthresearch.com>, selinux@tycho.nsa.gov
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Message-ID: <20040518114414.GA28412@lkcl.net>
References: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 07:50:34PM +1000, Les Bell wrote:
> 
> "Chris Babcock" <cbabcock@luthresearch.com> wrote:
> 
> >>
> Does this sound dangerous to anybody else?
> <<
> 
> Does the design of SELinux depend on the state machine theory of security,
> i.e. if a system starts in a secure state, and all transitions are secure,
> then the system will remain secure? 

 personally: i assume so (nothing else makes sense) on the basis that
 if you cannot change domain (because either libselinux is unavaiable
 or the programs that _use_ libselinux are somehow corrupted and
 unavailable) then you can go nowhere and therefore do no damage.


> This design would seem unable to
> support that theory, i.e. until the selinux library is loaded, there are no
> constraints on the state of the machine. Just a thought. . .
 
 yes you are right: there are issues, mentioned by russell,
 from initialisation (sysvinit) where if /usr/lib/libselinux.so
 is unavaiable (corrupted and in /lost+found) then the initialisation
 scripts would need to be modified to halt boot-up if the system
 is booted with selinux=1.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
