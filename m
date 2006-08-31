Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7V3CUds014877
	for <selinux@tycho.nsa.gov>; Wed, 30 Aug 2006 23:12:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7V3BrNt029582
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 03:11:53 GMT
Message-ID: <44F6539E.7090800@gentoo.org>
Date: Wed, 30 Aug 2006 23:12:30 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Klaus Weidner <klaus@atsec.com>, selinux@tycho.nsa.gov,
        Stephan Mueller <smueller@atsec.com>
Subject: Re: type transitioning script race condition?
References: <20060830223937.GB12307@w-m-p.com> <200608310918.03263.russell@coker.com.au>
In-Reply-To: <200608310918.03263.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thursday 31 August 2006 08:39, Klaus Weidner <klaus@atsec.com> wrote:
>  
>
>>This sounds as if it suffers from the well known race condition that
>>makes setuid shell scripts a bad idea - is there any protection in place
>>to prevent users from exploiting the race condition to run code of their
>>own choice in the new domain?
>>    
>>
>
>Correct.  As long as the script is run in a domain that has less privileges 
>than the calling code this isn't a problem.  If running a script causes a 
>transition to a more privileged domain then that's a policy bug.
>
>  
>
this happens quite a bit, including our own selinux management script 
semanage. In addition to the race condition (that is not fixable on 
Linux AFAIK) there are other environmental contamination issues,

There are some plans to fix the environmental contamination issues using 
a wrapper that cleanses the environment ala atsecure but the race is not 
fixable as far as I know.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
