Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96EdsT7026974
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 10:39:54 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96EdH03022254
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 14:39:17 GMT
Message-ID: <45266AB8.2050108@hp.com>
Date: Fri, 06 Oct 2006 10:39:52 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Denials from newest kernel
References: <36282A1733C57546BE392885C0618592015CFBCB@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFBCB@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>-----Original Message-----
>>From: Joshua Brindle [mailto:jbrindle@tresys.com]
>>Sent: Friday, October 06, 2006 8:32 AM
>>To: selinux@tycho.nsa.gov; Venkat Yekkirala
>>Subject: Denials from newest kernel
>>
>>I grabbed Erics new kernel builds and installed them and got some
>>interesting denials. I started with no secmark rules whatsoever on the
>>machine.
> 
> I would like Paul to first clear the netlabel changes as the culprit.

I'm rebuilding the source RPM without the NetLabel/secid patch as I type this.
I'll startup the "avahi-daemon" and post the audit messages I see as a result.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
