From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>, SELinux@tycho.nsa.gov
Subject: Re: How to get Xfree86 to run - old API
Date: Sun, 12 Oct 2003 17:38:53 +1000
References: <sf880644.030@atlas.snu.edu> <3F88FAEB.8000707@cisco.com>
In-Reply-To: <3F88FAEB.8000707@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310121738.53945.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 12 Oct 2003 16:55, Michael Reilly wrote:
> When trying to run the Xfree86 server using startx as
> michaelr:sysadm_r:sysadm_t

This is probably not something that is desirable.  startx often runs lots of 
things that shouldn't have full access to the system.

> the server does not startup.  This message is displayed
>
> Fatal server error:
> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

Do you have startx.te compiled into your policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
