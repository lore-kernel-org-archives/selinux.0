From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: general security lib (was: 2.6.0-test3)
Date: Sat, 23 Aug 2003 15:07:06 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308230009.19552.russell@coker.com.au> <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308231507.06879.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Aug 2003 00:32, Stephen Smalley wrote:
> If you investigate this idea, be sure to work from the new SELinux
> patches that use the new SELinux API, not the old one.  Note that the
> new SELinux API is better suited to encapsulation within PAM, since the
> exec context is now an attribute of the process that can be set prior to

I want to devise a suitable generic solution that it can be accepted into the 
PAM distribution.  Anything that can't support both old and new SE Linux APIs 
probably isn't nearly generic enough.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
