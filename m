Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k971IPIw015059
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 21:18:25 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k971HAWt001909
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 01:17:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: MMCS patch against subversion policy
Date: Sat, 7 Oct 2006 11:18:17 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200610062109.51031.russell@coker.com.au> <4526AC45.5090104@redhat.com>
In-Reply-To: <4526AC45.5090104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610071118.18718.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 October 2006 05:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> This is fine.  The only problem we have seen with MMCS is when an
> administrator logs in at SystemLow and su to root they have to be able
> to see and kill processes running at different levels.
> They should also be able to run the debugger against them.    If I am
> not using MCS I should not be hindered by it.

So you give the administrator the range SystemLow-SystemHigh and that's 
covered.  I can't imagine why you would want to give the administrator any 
different range.

> > The controversial patch is relabelling certain files under /selinux to
> > SystemHigh (it also needs restorecon run from /etc/rc.sysinit).  I know
> > that Steve won't like this and anticipate that others might not either. 
> > That's OK, the other two patches are useful without it.
>
> Not sure why you want to do this?

So that you can't trivially escape from the MCS part of the policy as root.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
