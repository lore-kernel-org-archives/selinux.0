Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HL1ZMd030202
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 17:01:35 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6HL1XFN023364
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 21:01:34 GMT
Message-ID: <469D2E2C.5020405@manicmethod.com>
Date: Tue, 17 Jul 2007 17:01:32 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
References: <20070717150336.135143158@manicmethod.com>	 <20070717150431.660417962@manicmethod.com>	 <1184686730.3833.11.camel@localhost.localdomain>	 <469CF0EC.8030704@manicmethod.com>	 <1184697355.3833.28.camel@localhost.localdomain>	 <469D2B2B.1080704@manicmethod.com> <1184705762.10625.14.camel@localhost.localdomain>
In-Reply-To: <1184705762.10625.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
>
>>  This first patch I was trying to keep it dead 
>> simple by not even requiring a custom packager and instead just using 
>> xar CLI. If we want to use more sophisticated things in xar (like 
>> per-file attributes) we'd need something custom. Even if we just make a 
>> subdocument (which is archive-wide in scope) and add some selinux bits 
>> to it like policy name that can still be done with the CLI.
>>
>> xar -xf foo.xar will unpackage it
>>     
>
> Ok - then I vote for a custom packaging tool. If nothing else it can
> retain some similarity to the current tool syntax.
>
>   
Ok, I'll go ahead and do that for the next version of the patches. We 
are basically taking a standard archive format and one-offing it, 
fortunately the format supports that kind of thing so we can continue 
using all their library infrastructure, which is a huge win over what we 
are doing now.

> [..]
>
>   
>>>>>   
>>>>>       
>>>>>           
>>>> There is no module_read function right now so thats just a placeholder.
>>>>
>>>>     
>>>>         
>>> There is if the module is source :)
>>>
>>>   
>>>       
>> nak.
>>     
>
> Why? Last time we discussed it you wanted support for storing additional
> information but the only examples that you had were original filename
> and line number. This is already supported (it has to be for the M4
> processing). So what else? If nothing else, why have an additional
> format?
>   

It doesn't seem reasonable to essentially reproduce the m4 preprocessing 
statements just to keep a single parser. just look at a preprocessed 
module and see how nasty it looks:

#line 156537 "tmp/all_interfaces.conf"
       
#line 1 "policy/modules/services/sendmail.te"

       
#line 2
      
#line 2
                module sendmail 1.3.1;
#line 2

#line 2
                require {
#line 2
                        role system_r;
#line 2


That isn't exactly what I had in mind when I said we'd want to store 
extra info. We'd also have to add parser support for that mess to the 
source parser, non-ideal I think when we can path the data in something 
easily readable (by machine) without loads of junk that isn't necessary.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
