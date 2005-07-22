Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MK1OgA009361
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:01:26 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJtmKk010015
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:55:48 GMT
Message-ID: <42E14F60.7090104@tresys.com>
Date: Fri, 22 Jul 2005 15:56:16 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>	<1122039886.24847.6.camel@celtics.boston.redhat.com>	<42E10804.5030401@tresys.com>	<1122046798.25951.27.camel@celtics.boston.redhat.com>	<42E146D3.60809@tresys.com> <1122061488.30783.14.camel@celtics.boston.redhat.com>
In-Reply-To: <1122061488.30783.14.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>

>Speaking of which... I'm duplicating your sepol_*_t records
>almost one-to-one in the libsepol api. I don't see a way around 
>that, however, because they are located in libsemanage.
>
>  
>
Why do you need them in libsepol? You don't need or want opaque types in 
libsepol, libsepol is a direct representation of the policy data 
structures. All the abstracted structures go in libsemanage.

<snip>

>It does matter, because I can write patches against it, and not write
>semod_ everywhere that I need to fix later.
>
>  
>
We aren't writing patches right now, we are trying to design a library. 
I'm really asking for your help to flesh out what is required for this 
API to work so that we can actually implement it.

>> Probably the best thing would be to write your user and port 
>>management stuff against the new API and see if it actually works.
>>    
>>
>
>I can't see if actually works, because there is no library to test it
>with. It used to work when it was in libselinux... I'm sure I'll have
>to change it a bit to fit with your structure names, and your apis,
>and your transaction processing.
>
>  
>
I mean that it works conceptually, ie: the API provides everything you 
need. Compiling and testing is very irrelavent right now since we are 
trying to design a very abstract management API for SELinux, something 
that needs to be carefully designed.

>>semanage_user_change(semanage_handle_t *, semanage_user_t *userdata, 
>>char* key);
>>it would totally replace the datum, no unioning or anything like that
>>    
>>
>
>If you're assuming character key, please assume character key in
>the delete functions as well. I'm not against it, simply pointing out..
>
>  
>
or we make opaque types for all keys and all datums just incase we want 
a composite key later.

>The drawback to not providing any more specific change functions 
>to the caller, is that now you have to do a query and a change for
>everything, even if all you're doing is adding information, and not
>extracting any. That means two iterations in the flat file case...
>but for the sake of simplicity and cleanness of API, maybe I'll agree.
>
>However, not having a query function is just wrong, I disagree with
>that.
>  
>
We'll add them, they are just convenience functions that will be added 
as needed.


Please, please stop focusing on the implementation details and help with 
the API design, I really need to know if this is sufficient for you 
(sans the labeling stuff that we are still working out). This is going 
to be an API that is used by every single tool that manages policy and 
it needs to be well thought out and flexible.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
