Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4HF2XZ024825
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 12:15:02 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4HF1cx005747
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 17:15:02 GMT
Date: Thu, 4 Nov 2004 17:25:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041104172547.GI5461@lkcl.net>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com> <20041103172609.GE5061@lkcl.net> <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 04, 2004 at 11:50:19AM -0500, Stephen Smalley wrote:
> On Wed, 2004-11-03 at 12:26, Luke Kenneth Casson Leighton wrote:
> >  the problem that SELinux faces is that as soon as you provide a
> >  seteuid-like function as a "sop" to help people adopt SElinux
> >  in applications, all bets are off for being able to remove
> >  it at a later date, and SELinux's security assurance is lost.
> 
> I don't think that this is a fair statement

 i am happy to be corrected.

> I would like to move forward with this proposal, going beyond a
> discussion of whether or not it should be implemented to how 

 cool.  elrond [samba-tng] is happy to create a real-world test
 of any such implementation.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
