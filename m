From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Kratzer, James R." <JamesK@xetron.com>,
   "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: can't start X window in enforce mode
Date: Fri, 17 Oct 2003 01:57:31 +1000
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A54@s3cin>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A54@s3cin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170157.31721.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 00:21, Kratzer, James R. wrote:
> I'm trying to get X-windows to start with enforce set to "1" without any
> luck.  I have moved the xserver.te file from the domains/program/unused
> directory to the domains/program directory.  I have changed the dontaudit
> line to allow as described here in the email below.  Any help would be
> appreciated.

We really can't help until you provide more information.

When you have the dontaudit rules removed, what avc messages are logged when 
you try to run the X server?

What messages does the X server log to syslog?

What messages does it display on the terminal?

How are you running the X server?  Do you type "startx" after logging in or do 
you use an XDM program?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
