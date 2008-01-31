Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0V2QUsL013115
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 21:26:30 -0500
Message-ID: <47A131D5.2030906@tycho.nsa.gov>
Date: Wed, 30 Jan 2008 21:26:29 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Glenn Faden <Glenn.Faden@sun.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>	 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>	 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>	 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov>	 <47878130.5010000@gmail.com> <4787D5B7.9090606@sun.com>	 <478FD1A7.8060401@tycho.nsa.gov> <4793FDC7.9050700@sun.com>	 <4797D7CB.6010501@tycho.nsa.gov> <cadfc0e40801290748v3e02a305i8ef36f39ceef16af@mail.gmail.com>
In-Reply-To: <cadfc0e40801290748v3e02a305i8ef36f39ceef16af@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> Has this made it into the git tree yet?
>   

I am running the compliance tests on it.  I will post the patch on the 
Xorg list for review this week.

I also need to make some changes to libselinux so the x_contexts file 
can contain the list of properties to polyinstantiate.  That will also 
be posted this week.

And finally, you're going to need to build a newer kernel, or backport 
the following short patch to an older kernel:
http://marc.info/?l=selinux&m=120120674815507&w=2


> On Jan 23, 2008 6:11 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>   
>> Glenn Faden wrote:
>>     
>>> Eamon Walsh wrote:
>>>
>>>       
>>>> OK, I worked on this today.  The property polyinstantiation itself is
>>>> easy enough, but I've run into a problem with the PropertyNotify
>>>> events that occur when a polyinstantiated property is changed or
>>>> deleted - everyone can see them!  Some major changes to the event
>>>> delivery model are probably going to be necessary to make this work.
>>>>
>>>> I can't immediately see how it's done in Trusted Extensions.  In
>>>> TsolDeleteProperty there is just a regular DeliverEvents call to send
>>>> the event.
>>>>
>>>> I think there will have to be a way to pass some private data down
>>>> with all events, and then have another hook call further down that
>>>> gives a yes/no answer for each client.
>>>>
>>>>         
>>> You're probably right that unnecessary PropertyNotify events may be
>>> distributed to any client who has expressed interest in this event on
>>> the root window. I don't think this is a big problem, however. If the
>>> client cares to read the property whose atom is associated with the
>>> event it will get the value which matches its security context.
>>>
>>> If your concern is that this presents a covert channel, that is an issue
>>> that we generally ignore. For example we don't prevent higher-level
>>> windows from generating exposure events which may be delivered to lower
>>> level windows. We only prevent normal clients from mapping windows into
>>> a Trusted Path workspace.
>>>
>>> --Glenn
>>>
>>>       
>> I'll press forward with this then, putting the event delivery on the
>> to-do list.
>>
>>
>>
>> --
>> Eamon Walsh <ewalsh@tycho.nsa.gov>
>> National Security Agency
>>
>>
>>     
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
