From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>
Subject: Re: can't start X window in enforce mode
Date: Thu, 16 Oct 2003 13:17:51 +1000
Cc: SELINUX <SELinux@tycho.nsa.gov>
References: <000901c390ef$d8b3c770$5d38a8c0@lky> <200310151018.09901.russell@coker.com.au> <20031015184330.732fc016.michaelr@cisco.com>
In-Reply-To: <20031015184330.732fc016.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310161317.51430.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Oct 2003 11:43, Michael Reilly wrote:
> Tried last night with DAC_READ_SEARCH instead of DAC_OVERRIDE - X server no
> go.  Same error about /dev/tty0 not being found.
>
> If it matters I am running the VESA frame buffer X server.  The HW vendor
> used an ATI video chip in a non-standard way to integrate a flat panel
> display so the ATI server doesn't find the flat panel.

The VESA frame buffer should not be a problem, it's what I use.

There may be some issues related to the differences between Debian and Red Hat 
X servers, I have not yet managed to get X working on a Red Hat machine due 
to kernel issues and lack of trying.

In any case I've changed my policy to allow dac_override.  It doesn't make any 
sense to allow setuid and setgid but deny dac_override.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
