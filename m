Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8A22J27004300
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 22:02:19 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8A22JZh027290
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 02:02:19 GMT
Message-ID: <48C72A87.9030009@manicmethod.com>
Date: Tue, 09 Sep 2008 22:01:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: semodule memory use
References: <200809101150.15440.russell@coker.com.au>
In-Reply-To: <200809101150.15440.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495786
> 
> I've received the above bug report against the Debian policy packages.  The 
> operation in question is "semodule -b" followed by "semodule -i".
> 
> I haven't had time to work on this (and won't until well after Lenny is 
> released).  But if anyone has any quick ideas of how to reduce memory use by 
> semodule then I would be interested to hear them.
> 

how big is the policy in terms of rules? if it is even close to the size of fedora's there is no chance of it running in under 32 meg.

You'll need a significantly smaller policy to reduce the memory usage. There is no quick answer, we've already picked most of the low hanging fruit (releasing modules earlier, consuming the linked policy while expanding, reducing the size of the type datum, etc).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
