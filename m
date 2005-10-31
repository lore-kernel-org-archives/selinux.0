Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9VGkmMA014674
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 11:46:49 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9VGfxmc029635
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 16:42:00 GMT
Message-ID: <43664950.80600@redhat.com>
Date: Mon, 31 Oct 2005 11:41:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: unreasonably long SE Linux context display
References: <200510311812.02462.russell@coker.com.au> <FE184DBF-12F5-4387-AC3E-71A2B64E69FA@nall.com>
In-Reply-To: <FE184DBF-12F5-4387-AC3E-71A2B64E69FA@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
>
> On Oct 31, 2005, at 1:11 AM, Russell Coker wrote:
>
>> Would it be possible to use shorter names in the setrans.conf file than
>> SystemLog and SystemHigh?  For example could we have "Low-High" or
>> "sLow-sHigh" instead?
>
> How about adding a capability to name ranges and shorten
>  "SystemLow-SystemHigh"
> to
>  "all"
> or even
>  "*"
setrans is under your control.  You can change SystemLow-SystemHigh to 
anything you want.

Russell is suggesting we change the default.
>
> joe
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
