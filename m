From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>
Subject: Re: Yet another question - newrole and xterm's
Date: Fri, 17 Oct 2003 13:39:33 +1000
Cc: SELinux@tycho.nsa.gov
References: <20031015191716.5478c74b.michaelr@cisco.com> <200310170216.37933.russell@coker.com.au> <20031016104026.78cacc68.michaelr@cisco.com>
In-Reply-To: <20031016104026.78cacc68.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310171339.33673.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 03:40, Michael Reilly wrote:
> I am running old SElinux.  I verified last night - put the entry back as
> dontaudit and newrole says the password does not match - looking at the
> newrole.c code I think this is the result it received from PAM.

What PAM modules are you using?  Is anything logged to auth.log?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
