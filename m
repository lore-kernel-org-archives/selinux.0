Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m190fKTp004307
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 19:41:20 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m190fJ7a003644
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2008 00:41:19 GMT
Received: by py-out-1112.google.com with SMTP id a78so4668150pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 08 Feb 2008 16:41:19 -0800 (PST)
Message-ID: <47ACF626.7090004@gmail.com>
Date: Fri, 08 Feb 2008 18:39:02 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Glenn Faden <Glenn.Faden@sun.com>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: add "poly_property" type to X contexts backend
References: <47A8D586.7080202@tycho.nsa.gov> <cadfc0e40802051412p393dd42ei3632bee0b9842b73@mail.gmail.com> <47A9047D.1000501@tycho.nsa.gov> <47A9DA5D.2030109@sun.com> <47AA0A2C.6090009@tycho.nsa.gov>
In-Reply-To: <47AA0A2C.6090009@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Glenn Faden wrote:
>> Eamon Walsh wrote:
>>  
>>> Xavier Toth wrote:
>>>    
>>>> I'm curious as to why you chose the route of specifying which
>>>> properties are polyinstantiated instead of which are not bearing in
>>>> mind what Glenn said in a previous post?
>>>>         
>>> The server will check the "property" lines first and if it doesn't 
>>> find a match it will check the "poly_property" lines.  So, as long 
>>> as the wildcard entry in the x_contexts file is changed from 
>>> property to poly_property, the default will be to polyinstantiate.
>>>
>>> However I wasn't planning on treating the root window any 
>>> differently from other windows, so this behavior would apply to all 
>>> windows.
>>>     
>> I've never seen a requirement for polyinstantiation of properties on 
>> per-client windows. I've seen requirements for relabeling properties, 
>> however. For example, the trusted selection manager needs to create 
>> properties that are readable by the client who requests a 
>> ConvertSelection. We do this by calling a new X protocol extension.
>
> SELinux protocol extension allows clients to create windows and 
> properties with different security contexts.
>
>>  How do you plan to have trusted clients act on behalf of other 
>> clients with different security contexts?
>
> I haven't done the polyinstantiation for selections yet, but my 
> current plan is to implement a trusted clipboard manager that will 
> display the various clipboard contents and allow users to upgrade or 
> downgrade, which means that the clipboard manager will take ownership 
> of the selection at the target level and just pipe the data through.  
> This scheme shouldn't require tweaking properties on the fly.  However 
> this would not be point-to-point but would make the selection 
> available to all applications at the target level.
>
This is extremely high on our list of 'must have's and it is critical 
that this be targeted for RHEL6 is this your goal too?

>> Similarly, how can a trusted client read/write a polyinstantiated 
>> property with a different security context?
>>   
>
> By launching a helper process at the appropriate level.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
