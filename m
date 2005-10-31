Subject: Re: unreasonably long SE Linux context display
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <FE184DBF-12F5-4387-AC3E-71A2B64E69FA@nall.com>
References: <200510311812.02462.russell@coker.com.au>
	 <FE184DBF-12F5-4387-AC3E-71A2B64E69FA@nall.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:39:05 -0500
Message-Id: <1130776745.22731.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 10:18 -0600, Joe Nall wrote:
> On Oct 31, 2005, at 1:11 AM, Russell Coker wrote:
> 
> > Would it be possible to use shorter names in the setrans.conf file  
> > than
> > SystemLog and SystemHigh?  For example could we have "Low-High" or
> > "sLow-sHigh" instead?
> 
> How about adding a capability to name ranges and shorten
>   "SystemLow-SystemHigh"
> to
>   "all"
> or even
>   "*"

Originally, Dan was just mapping it to "SystemHigh", but that caused
problems on the reverse translation ("SystemHigh" ==
"SystemHigh-SystemHigh", not "SystemLow-SystemHigh").  I suppose you can
define "all" or "*" any way you want in setrans.conf, but it seems prone
to similar confusion.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
