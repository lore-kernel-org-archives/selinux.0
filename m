From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>
Subject: Re: can't start X window in enforce mode
Date: Wed, 15 Oct 2003 10:18:09 +1000
Cc: SELINUX <SELinux@tycho.nsa.gov>
References: <000901c390ef$d8b3c770$5d38a8c0@lky> <1066143647.5054.178.camel@moss-spartans.epoch.ncsc.mil> <20031014120207.6a29818e.michaelr@cisco.com>
In-Reply-To: <20031014120207.6a29818e.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310151018.09901.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Oct 2003 05:02, Michael Reilly wrote:
> I did find the problem - the X server needed DAC_OVERRIDE.  This was logged
> as soon as I removed the dontaudit's

Why did it need DAC_OVERRIDE?

Why not DAC_READ_SEARCH?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
