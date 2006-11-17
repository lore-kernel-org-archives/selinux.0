Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHIXcgL006253
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 13:33:38 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kAHIWswh021819
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 18:32:54 GMT
Message-ID: <455E008E.3040707@tresys.com>
Date: Fri, 17 Nov 2006 13:33:50 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs
References: <453E2A8C.4070207@redhat.com> <200611160433.09138.russell@coker.com.au> <1163684980.7374.26.camel@sgc.columbia.tresys.com> <200611180007.07194.russell@coker.com.au>
In-Reply-To: <200611180007.07194.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 17 November 2006 00:49, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> 
> Any directory on the system that contains application data could be replaced 
> by a tmpfs filesystem and require a $1_tmpfs_t type for the least intelligent 
> use.  As an example I once ran a MySQL database with a tmpfs for the database 
> store.
> 

Eh? Why? MySQL has a memory backed database type, this is an unnecessary 
layer of indirection.

It makes sense for some apps but not others, why add lots of completely 
unnecessary policy?

> The correct solution for such cases is to use either restorecon or a -o 
> context= mount option to give it the expected type.  It's worked for me every 
> time I've tried such things.
> 
>>> Maybe we could have restorecon run on the Squid spool directory to
>>> cater for the case of using tmpfs for it if people want to do that.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
