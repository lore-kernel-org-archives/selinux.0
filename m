Date: Wed, 15 Oct 2003 18:43:30 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: can't start X window in enforce mode
Message-Id: <20031015184330.732fc016.michaelr@cisco.com>
In-Reply-To: <200310151018.09901.russell@coker.com.au>
References: <000901c390ef$d8b3c770$5d38a8c0@lky>
	<1066143647.5054.178.camel@moss-spartans.epoch.ncsc.mil>
	<20031014120207.6a29818e.michaelr@cisco.com>
	<200310151018.09901.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tried last night with DAC_READ_SEARCH instead of DAC_OVERRIDE - X server no
go.  Same error about /dev/tty0 not being found.

If it matters I am running the VESA frame buffer X server.  The HW vendor
used an ATI video chip in a non-standard way to integrate a flat panel
display so the ATI server doesn't find the flat panel.

michael
On Wed, 15 Oct 2003 10:18:09 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Wed, 15 Oct 2003 05:02, Michael Reilly wrote:
> > I did find the problem - the X server needed DAC_OVERRIDE.  This was
> > logged as soon as I removed the dontaudit's
> 
> Why did it need DAC_OVERRIDE?
> 
> Why not DAC_READ_SEARCH?
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
