Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1O0gxRb020595
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 19:42:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1O0fOlK025314
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 00:41:24 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1O0fNOX025255
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 00:41:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: identity
Date: Tue, 24 Feb 2004 11:41:32 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200402231535.26738.russell@coker.com.au> <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402241141.32355.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Feb 2004 01:28, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Sun, 2004-02-22 at 23:35, Russell Coker wrote:
> > One of the benefits of the SE Linux identity is that it tracks the
> > originating user through all operations that they perform.
>
> Caveat:  This is no longer entirely true, as 'su' is now using
> pam_selinux and transitions to other user identities.

Yes.  However I plan to make such use of su an optional feature so that people 
who desire the previous identity functionality where it can not be set by 
anything other than a login program can get it with minimal effort.

The Fedora default settings won't be used by everyone and I hope that when we 
release RHEL 4 we will have a good number of customers who want all the 
better security options enabled.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
