Date: Thu, 31 Jul 2003 17:38:10 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: Bill Laut <wlsel@verizon.net>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Message-ID: <20030731173810.E16284@lemuria.org>
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <200307301803.29302.wlsel@verizon.net> <20030731044521.H13872@lemuria.org> <200308010126.58444.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308010126.58444.russell@coker.com.au>; from russell@coker.com.au on Fri, Aug 01, 2003 at 01:26:58AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 01, 2003 at 01:26:58AM +1000, Russell Coker wrote:
> Using IRC without X access is no great hardship, while using a text based MUA 
> loses significant functionality.  

Uh?
<img content="stupid look on face of an avid mutt user">

> X is currently the main area that SE Linux 
> does not address yet.

True. However, that is not a problem specific to a MUA.


> A mail client wants to access mail files under the user's home directory, this 
> means that the files in question need a separate type as you don't want the 
> mail client to access all the other files in the home directory.  This gives 
> the usual issues of mv followed by file creation giving a different type and 
> preventing things working in a way that novice users can't debug...

I'd do this the same way I did it with my subversion policy: Set up the
mail directory so that only the MUA (running in its own domain) can
access it. That way, the user simply can't mess up file labels.


> The mail client needs to be able to save files (easily managed) and to invoke 
> the web browser and other programs (which may be more difficult).

I've been wanting to create a "downloaded files" domain for netscape
anyways. Did I post about that already? In short, there'd be a
~/Downloads dir with a special type and some auto-trans rules so that
stuff you download and "try out" runs in an untrusted domain, etc.

Maybe we should just create a more general "untrusted files" domain?


> Finally if using kmail then you have to deal with the kdeinit method of 
> program launch...

I smell an SEKDE project on the horizon. From what I've seen, KDE is
way too integrated with itself to behave nicely with SE without changes 
in the KDE code itself.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
