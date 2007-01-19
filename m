Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0JDNSYf015226
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 08:23:28 -0500
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0JDONTB025973
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 13:24:24 GMT
Message-ID: <45B0C687.4010707@nagafix.co.uk>
Date: Fri, 19 Jan 2007 13:24:23 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov
Subject: Re: 2.6.19.2 Oops
References: <45B09CFA.5070805@nagafix.co.uk> <200701190818.27289.paul.moore@hp.com>
In-Reply-To: <200701190818.27289.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 19 January 2007 5:27 am, Antoine Martin wrote:
>> I tried to upgrade a system which had been running very smoothly for
>> quite some time (enforcing=1), but it just Oopsed with 2.6.19.2, even in
>> non-enforcing mode, I had to use selinux=0 to get anywhere (otherwise
>> the Oops below just scrolled on the console)
> 
> This looks to be related to NetLabel as the Oops is happening in 
> mls_export_cat().  Could you do the following in gdb and report the results 
> so that we can get a better idea of what instruction is causing the NULL 
> dereference:
> 
>  (gdb) list *mls_export_cat+0x33
Not sure how to do this on a running kernel, where do I get the symbols 
from? assuming they were compiled in (also the running kernel's cmdline 
has selinux=0)

> Also, can you tell us what distribution and SELinux policy you are using?
Gentoo 2005.1/x86:
libselinux 1.30
libsemanage 1.6
libsepol 1.12-r1

> Thanks for reporting this.
np.

Antoine

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
