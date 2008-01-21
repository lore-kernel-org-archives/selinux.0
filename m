Date: Sun, 20 Jan 2008 18:04:55 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <478FD1A7.8060401@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <4793FDC7.9050700@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov>
 <47878130.5010000@gmail.com> <4787D5B7.9090606@sun.com>
 <478FD1A7.8060401@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
>  
> OK, I worked on this today.  The property polyinstantiation itself is 
> easy enough, but I've run into a problem with the PropertyNotify 
> events that occur when a polyinstantiated property is changed or 
> deleted - everyone can see them!  Some major changes to the event 
> delivery model are probably going to be necessary to make this work.
>
> I can't immediately see how it's done in Trusted Extensions.  In 
> TsolDeleteProperty there is just a regular DeliverEvents call to send 
> the event.
>
> I think there will have to be a way to pass some private data down 
> with all events, and then have another hook call further down that 
> gives a yes/no answer for each client.
You're probably right that unnecessary PropertyNotify events may be 
distributed to any client who has expressed interest in this event on 
the root window. I don't think this is a big problem, however. If the 
client cares to read the property whose atom is associated with the 
event it will get the value which matches its security context.

If your concern is that this presents a covert channel, that is an issue 
that we generally ignore. For example we don't prevent higher-level 
windows from generating exposure events which may be delivered to lower 
level windows. We only prevent normal clients from mapping windows into 
a Trusted Path workspace.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
