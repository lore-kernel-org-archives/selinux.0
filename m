Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HM7aCv028795
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 17:07:36 -0500
Message-ID: <478FD1A7.8060401@tycho.nsa.gov>
Date: Thu, 17 Jan 2008 17:07:35 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Glenn Faden <Glenn.Faden@sun.com>
CC: Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com> <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com> <47754FCB.1070307@tycho.nsa.gov> <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com> <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com> <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov> <47878130.5010000@gmail.com> <4787D5B7.9090606@sun.com>
In-Reply-To: <4787D5B7.9090606@sun.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glenn Faden wrote:
> Ted X Toth wrote:
>   
>> I'll look at implementing a dixPropertyLookup function. Do any other 
>> XACE hooks have value-return parameters, would it just be va_arg(ap, 
>> PropertyPtr*)?
>> What about the idea of an exception list of single-instance 
>> root-window properties?
>>
>>     
> We have already implemented the equivalent of a dixPropertyLookup 
> function called PolyProperty. The following URL is an OpenSolaris source 
> browser query to find the implementation and uses of that function in Xorg.
>
> http://src.opensolaris.org/source/search?q=&defs=&refs=PolyProperty&path=&hist=&project=%2Ffox
>
> --Glenn
>   

OK, I worked on this today.  The property polyinstantiation itself is 
easy enough, but I've run into a problem with the PropertyNotify events 
that occur when a polyinstantiated property is changed or deleted - 
everyone can see them!  Some major changes to the event delivery model 
are probably going to be necessary to make this work.

I can't immediately see how it's done in Trusted Extensions.  In 
TsolDeleteProperty there is just a regular DeliverEvents call to send 
the event.

I think there will have to be a way to pass some private data down with 
all events, and then have another hook call further down that gives a 
yes/no answer for each client.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
