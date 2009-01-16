Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GHIiT1008164
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 12:18:44 -0500
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GHIgN9021296
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 17:18:43 GMT
Received: by yw-out-1718.google.com with SMTP id 6so701618ywa.84
        for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 09:18:42 -0800 (PST)
Message-ID: <4970C16E.6030107@gmail.com>
Date: Fri, 16 Jan 2009 09:18:38 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
References: <496D759A.7010401@gmail.com> <200901151752.06622.paul.moore@hp.com> <dd18b0c30901151644q4578f7d6k3023cad6f05325dd@mail.gmail.com> <200901161109.27222.paul.moore@hp.com>
In-Reply-To: <200901161109.27222.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 15 January 2009 7:44:15 pm Justin Mattock wrote:
>   
>> On Thu, Jan 15, 2009 at 2:52 PM, Paul Moore <paul.moore@hp.com> wrote:
>>     
>>> Well, it is possible that /bin/sh points to a non-bash shell but
>>> maybe not (I'm pretty sure the make command executes the scripts
>>> with /bin/sh).  Either way, I checked in the fix to the SVN tree
>>> earlier today so newer releases will have the fix; if needed I can
>>> release a 0.19.1 or similar but I want to wait and see how
>>> widespread the problem is ...
>>>
>>> --
>>> paul moore
>>> linux @ hp
>>>       
>> Cool, If I see anybody
>> struggling, I point them to the
>> fix you posted.
>>     
>
> Great.  Also let me know, if this looks like it will be widespread 
> problem I'll make a new release; I'd hate for people to have to patch 
> the Makefile to get it to build ...
>
>   
no problem.
>> I also might be missing something, i.g.
>> one of the boxes that gave this error I built
>> with debootstrap, but then the other that gave this as well
>> was built with nubuntu which seems more complete
>> than debootstrap.
>> but then maybe both are missing a package.
>> (or it's a debian thing)
>>     
>
> It could also be my rather poor understanding of bash and makefiles :)  
> If anyone out there wants to take a look and offer an explanation or a 
> better patch I'm more than happy to accept it.
>
>   
here as well.

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
