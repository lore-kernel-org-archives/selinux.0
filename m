Message-ID: <47866A60.40002@tresys.com>
Date: Thu, 10 Jan 2008 13:56:32 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, cpebenito@tresys.com,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: Q: SECMARK controls on forwarded packets
References: <200801082330.58907.paul.moore@hp.com> <200801091548.10359.paul.moore@hp.com> <D709A20F2164C84E8B7014B0301F5EF8A0DD2A@HAVOC.tcs-sec.com> <200801101147.06142.paul.moore@hp.com>
In-Reply-To: <200801101147.06142.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 10 January 2008 10:32:10 am Chad Hanson wrote:
>> These controls look good to us...
> 
> Great.  I'm assuming the lack of complaints means others are happy with 
> this as well.
> 

I haven't gotten around to looking at the rfc in detail but it looks 
like the secmark/external labeling concepts are being merged again when 
we already decided to keep them as separate systems. Is the claim here 
that it isn't possible to do forwarding controls without interaction 
between them?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
