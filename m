Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EGuQHa013390
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:56:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6EGtQnJ019963
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 16:55:26 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6EGtOhr019948
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 16:55:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: another patch for the new release
Date: Tue, 15 Jul 2003 02:56:11 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200307122201.06936.russell@coker.com.au> <1058200198.13738.652.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1058200198.13738.652.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307150256.11377.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Jul 2003 02:29, Stephen Smalley wrote:
> On Sat, 2003-07-12 at 08:01, Russell Coker wrote:
> > I think that it is desirable that when a user is authorized for user_r
> > and staff_r that staff_r is the default.
>
> It doesn't really work to authorize a user for user_r and staff_r;

So does this mean that we don't support the idea of changing to a less 
priviledged role to run untrusted programs?

I guess that using a different Unix account for such things will work, as 
anyone who is in staff_r can surely have their request for an extra account 
granted.

> > xstat_conv.h doesn't work for me, it seems that struct kern_stat not
> > struct stat is required.  Haven't fully tested this yet but at least it
> > makes it compile.
>
> I don't think that this is what you want.  If you are using older glibc
> with the old stat definitions, try using the older libsecure, i.e. the
> one prior to this release.  In any event, this will be obsoleted by the
> new API.

I'm using glibc 2.3.1, is it required to use 2.3.2 to get this to compile 
correctly?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
