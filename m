Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JJ20gA009525
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:02:00 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JIuvZb009585
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 18:56:57 GMT
Message-ID: <42DD4D40.3010001@redhat.com>
Date: Tue, 19 Jul 2005 14:58:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: init running at s9 by default on a MLS system?
References: <36282A1733C57546BE392885C0618592AF2872@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592AF2872@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:

>>How do you specify in policy that kernel_t transitions to 
>>init_t but at 
>>level s0?
>>
>>    
>>
>
>Like as follows:
>
># run init_t at OS_LO-OS_HI
>range_transition kernel_t init_exec_t s0 - s9:c0.c127;
>
>-Chad
>  
>
That line is already in policy.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
