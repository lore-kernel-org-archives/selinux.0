Message-Id: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 09:16:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040413175338.GA713@xtl1.xtl.tenegg.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Tom Mitchell
> Sent: Tuesday, April 13, 2004 1:54 PM
> To: SELinux
> Subject: Re: Now that SELinux supports booleans should we replace tunables
> with booleans?
> 
> On Tue, Apr 13, 2004 at 09:59:42AM -0400, Daniel J Walsh wrote:
> 
> > Ideas?
> 
> The fewer decisions the kernel needs to make the better.  i.e. The
> more decisions and analysis that can be make in advance of loading
> policy the better.
> 

I'm not certain this is the case. Booleans allow for fine-grained control
over policy changes by domains without full policy privileges (see my other
recent mail in this thread for more on this). This makes it easier to
analyze a policy ahead of time to make certain that it meats your security
goals in all configurations.

If you are concerned about performance, I don't think that is a problem
either. The conditional support adds minimal overhead that is probably taken
care of by the avc cache anyway.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> 
> --
> 	T o m  M i t c h e l l
> 	/dev/null the ultimate in secure storage.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
