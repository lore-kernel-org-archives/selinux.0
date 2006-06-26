Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k61CBawR000907
	for <selinux@tycho.nsa.gov>; Sat, 1 Jul 2006 08:11:36 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k61CBZU9029343
	for <selinux@tycho.nsa.gov>; Sat, 1 Jul 2006 12:11:35 GMT
Message-ID: <449FD1CE.8020908@redhat.com>
Date: Mon, 26 Jun 2006 08:23:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: 2/2 Convert functions to use new get,set
 procattrcon
References: <1151094771.21012.94.camel@localhost.localdomain>	 <1151111346.21635.131.camel@code.and.org> <1151130423.21012.107.camel@localhost.localdomain>
In-Reply-To: <1151130423.21012.107.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Fri, 2006-06-23 at 21:09 -0400, James Antill wrote:
>   
>> On Fri, 2006-06-23 at 16:32 -0400, Eric Paris wrote:
>>     
>>> The below patch will convert
>>>
>>> -{get,set}fscreatecon()
>>> -{get,set}execcon()
>>> -{get,set}con()
>>> -getpidcon()
>>> -getprevcon()
>>>
>>> to use the new {get,set}procattrcon() generic functions.  The only two
>>> caveats are
>>>
>>> both getprevcon_raw() and getcon_raw() had callers elsewhere in
>>> libselinux.  So the raw version of these functions were left and now
>>> call directly into the raw version of the generic functions.
>>>       
>>  I see you removed a bunch of *_raw() functions, you've changed the ABI
>> of the library and broken at least secon (in policycoreutils) and
>> gnome-vfs2. Is that intentional?
>>
>>  The hidden_def() doesn't make them library local functions, just
>> creates the hidden version as an alias ... so ignore that part of my
>> previous email.
>>     
>
> Obviously I wasn't intending to break other things.   I thought the
> hidden portion was actually making them library local and so I just
> checked to make sure there were no other users in the library, that and
> my machine didn't die a horrible death when I started using it.  They
> are very simple to add back and I will post a patch that returns the
> _raw functions and so doesn't change the abi at all on Monday.
>
> -Eric
>
>   
The raw functions are for applications that do not want translations.  
Actually any
application that does not display the data to users should use the _raw.
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
