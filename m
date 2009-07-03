Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n633YdVe027088
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 23:34:39 -0400
Received: from mail-pz0-f187.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n633ZF9X017274
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 03:35:16 GMT
Received: by pzk17 with SMTP id 17so141067pzk.32
        for <selinux@tycho.nsa.gov>; Thu, 02 Jul 2009 20:34:37 -0700 (PDT)
Message-ID: <4A4D7C94.2020307@gmail.com>
Date: Thu, 02 Jul 2009 20:35:48 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SElinux: Fix some typos.
References: <1246556775-8942-1-git-send-email-justinmattock@gmail.com> <1246556775-8942-2-git-send-email-justinmattock@gmail.com> <alpine.LRH.2.00.0907030850500.10242@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0907030850500.10242@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 2 Jul 2009, Justin P. Mattock wrote:
>
>    
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>
>> Fix some typos in some comments.
>>      
>
>    
>> -/* The file system's label must be initialized prior to use. */
>> +/* The filesystems label must be initialized prior to use. */
>>      
>
> Your adding grammertical error's.
>
>    
well, after figuring out how to have git send -email functioning correctly,
I needed something to send.      : ^ )
(but after doing a quick google filesystem did show up).
>> -	 * Note that the setting of hard limits (even to lower them) can be
>> +	 * Note: That the setting of hard limits (even to lower them) can be
>>      
>
> Please get this patch reviewed by an English speaker.
>
>    
That seems viable to me.
>>    * Description:
>>    * Call the NetLabel mechanism to get the security attributes of the given
>> - * packet and use those attributes to determine the correct context/SID to
>> - * assign to the packet.  Returns zero on success, negative values on failure.
>> + * packet and use those attributes to determine the correct context/SID to be
>> + * assigned to the packet.  Returns zero on success, negative values on failure.
>>      
>
> Eschew the active voice?
>
>
> - James
>    
wast ist das?
No I will not be afraid of submitting patches, and having them be rejected.
all part of the learning curve.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
