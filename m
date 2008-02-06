Date: Wed, 06 Feb 2008 08:03:41 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [PATCH] libselinux: add "poly_property" type to X contexts backend
In-reply-to: <47A9047D.1000501@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-id: <47A9DA5D.2030109@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <47A8D586.7080202@tycho.nsa.gov>
 <cadfc0e40802051412p393dd42ei3632bee0b9842b73@mail.gmail.com>
 <47A9047D.1000501@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Xavier Toth wrote:
>> I'm curious as to why you chose the route of specifying which
>> properties are polyinstantiated instead of which are not bearing in
>> mind what Glenn said in a previous post?
>>   
>
> The server will check the "property" lines first and if it doesn't 
> find a match it will check the "poly_property" lines.  So, as long as 
> the wildcard entry in the x_contexts file is changed from property to 
> poly_property, the default will be to polyinstantiate.
>
> However I wasn't planning on treating the root window any differently 
> from other windows, so this behavior would apply to all windows.
I've never seen a requirement for polyinstantiation of properties on 
per-client windows. I've seen requirements for relabeling properties, 
however. For example, the trusted selection manager needs to create 
properties that are readable by the client who requests a 
ConvertSelection. We do this by calling a new X protocol extension. How 
do you plan to have trusted clients act on behalf of other clients with 
different security contexts? Similarly, how can a trusted client 
read/write a polyinstantiated property with a different security context?

--Glenn


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
