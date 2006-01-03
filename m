Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k035u5Xf014785
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 00:56:06 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k035t5qa027746
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 05:55:06 GMT
Message-ID: <43BA11DD.4000907@tresys.com>
Date: Tue, 03 Jan 2006 00:55:41 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsetrans and libselinux
References: <200601031411.13500.russell@coker.com.au> <43B9FAAD.10809@redhat.com>
In-Reply-To: <43B9FAAD.10809@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Russell Coker wrote:
> 
>> Does it make sense to have two separate libraries for these functions?
>>
>> It seems that they are both maintained by much the same group of 
>> people, will in many cases need updating at the same time, and will 
>> mostly be linked to by all the same programs, very few programs need 
>> libselinux but not libsetrans and that number is constantly decreasing 
>> and it's impossible to use libsetrans without using libselinux.
>>
>> If we have a single library then there are some small optimisations 
>> that will occur, reducing load time and reducing the resident set size 
>> by a couple of pages.
>>
>>   
> 
> The reason they are separate is so that you could build a replacement 
> for libsetrans and use it with libselinux.  The idea was someone
> might use the Mitre tranaslation library in place of libsetrans.
> 

The only users of libsetrans are ones that use context functions in 
libselinux, and several apps that link to libselinux but don't use those 
(such as load_policy, init, etc)

Further, IIRC libsetrans is being maintained by RH and is not in the nsa 
mainline cvs tree. And as Dan was saying, the whole reason for 
libsetrans to begin with was for drop in translation libraries (such as 
Mitre's)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
