Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9ODpZRq012392
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 09:51:35 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9ODpRXg029133
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 13:51:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: policyd module
Date: Wed, 24 Oct 2007 23:49:53 +1000
Cc: Jan-Frode Myklebust <janfrode@tanso.net>, selinux@tycho.nsa.gov
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com> <20071023160316.GA10042@lc4eb8045376502.ibm.com> <1193231312.9466.104.camel@gorn>
In-Reply-To: <1193231312.9466.104.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710242349.55640.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 24 October 2007 23:08, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Tue, 2007-10-23 at 18:03 +0200, Jan-Frode Myklebust wrote:
> > Resending this one, as it seems to have dropped of your radar. Still
> > applies to refpolicy-head.
>
> I'm wrestling with the naming.  Policyd, while its the name of the
> server, seems far too generic.  It seems like postfix_policyd would be
> better.

Or maybe even a more generic mta_policyd.  If you make a policy that's generic 
enough for the majority of Postfix policy server modules then getting it to 
also work for Sendmail milters etc should not be difficult.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
