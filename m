Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n636MII8008730
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 02:22:18 -0400
Received: from mail-px0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n636MtwO018724
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 06:22:55 GMT
Received: by pxi40 with SMTP id 40so1431488pxi.32
        for <selinux@tycho.nsa.gov>; Thu, 02 Jul 2009 23:22:16 -0700 (PDT)
Message-ID: <4A4DA3E0.6050404@gmail.com>
Date: Thu, 02 Jul 2009 23:23:28 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SElinux: Fix some typos.
References: <1246556775-8942-1-git-send-email-justinmattock@gmail.com> <1246556775-8942-2-git-send-email-justinmattock@gmail.com> <alpine.LRH.2.00.0907030850500.10242@tundra.namei.org> <4A4D7C94.2020307@gmail.com> <alpine.LRH.2.00.0907031544160.12340@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0907031544160.12340@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 2 Jul 2009, Justin P. Mattock wrote:
>
>    
>> No I will not be afraid of submitting patches, and having them be rejected.
>> all part of the learning curve.
>>      
>
> I'd suggest generally not starting out with spelling, grammatical and
> formatting patches.  It eats reviewer bandwidth, perturbs the codebase
> (causing people working on it to have to update their code) and does not
> give you as much opportunity to to learn about the code.
>
>    
No my intentions were not to eat reviewer bandwidth, or get in the way.
just turned out as I was going through(for example) hooks.c I noticed a 
portion of it
had proper grammar, and then a portion of it seemed as if the author was too
much in a hurry to worry about that.(so I figured hey why not, that's all).
> Try fixing smaller, known bugs or adding small useful changes.
>
> The TODO list for the SELinux kernel code is here:
> http://selinuxproject.org/page/Kernel_Development
>
>    
Thanks for this, Ill have to give this a look and see.

> You can also email the maintainers and ask for suggestions on what to
> tackle.
>
>
> - James
>    
alright James,
Thanks for taking the time
next time I decide to have a major case of
OCD, I'll remember that creating churn is not
a good idea.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
