From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: Limiting the power of can_network, improving the security of strict policy.
Date: Thu, 28 Oct 2004 21:07:13 +1000
Cc: jayendren@hivsa.com, "'steven harp'" <steven.harp@adventiumlabs.org>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAtvBgX3z5LkOux3E0aOx0UAEAAAAA@hivsa.com> <200410272039.i9RKdeGl004055@turing-police.cc.vt.edu>
In-Reply-To: <200410272039.i9RKdeGl004055@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410282107.13472.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Oct 2004 06:39, Valdis.Kletnieks@vt.edu wrote:
> SELinux is about *authorization*, not authentication.  Your best bet for
> securing authentication is to look at customize PAM modules - SELinux
> basically assumes that "If PAM allowed this user to login this role, they
> must be authenticated, so we'll provide authorization appropriate for
> the user's role".

There is a SE Linux related issue in this.  In the future we will be 
supporting other methods of authentication.  There are useful methods of 
authentication such as smart-cards which may have similar interfaces to the 
OS as useless things such as biometrics.

We need to make sure that only certain applications can communicate with the 
authentication hardware, and the hardware in question may have multiple 
capabilities (think of a smart-card that authenticates the user and also has 
a GPG implementation).  So we will probably need a user-space object manager 
to control access to the security hardware.  Finally we need a trusted path 
so that a GPG card will only sign things when instructed by the user (not a 
trojan).

> Note that biometrics do *not* automagically make it more secure - in
> particular, they don't do very much at all for securing network access.
> Improperly used, they make things *worse* (how do you revoke credentials
> based on an iris scanner, for instance? ;)

Remove the eye.  ;)

One big disadvantage of biometric systems is the risk of theft.  Having keys 
or cards stolen is bad, having an eye or a finger stolen is really bad.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
