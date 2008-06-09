MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: releasibility in mcstransd
Date: Mon, 9 Jun 2008 17:04:52 -0400
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com>
References: <484D91BB.3080904@manicmethod.com>
From: "Chad Hanson" <chanson@TrustedCS.com>
To: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
Seems reasonable to me unless you want to create a nice new encoding
language ;)

How would the user process translate, eg, s0:c102.c128, just s0?

-Chad 

> 
> I am adding releasibility support to mcstransd and just 
> wanted to see if there were any comments or complaints to 
> what I'm planning here.
> 
> Rather than adding a generic prefix mechanism like the CMW 
> encodings I did something specific for releasibility, in setrans.conf:
> 
> releasibility c100.c128
> 
> then encodings look like:
> 
> s0:~c100 = rel_US
> s0:~c101 = rel_Texas
> 
> so a file with s0:c102.c128 would translate to s0:rel_US,rel_Texas.
> 
> any comments? Does anyone think this is absolutely the wrong approach?
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
