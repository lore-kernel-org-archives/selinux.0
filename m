Date: Wed, 09 Jan 2008 09:46:50 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <4784D86C.1070503@gmail.com>
To: Ted X Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-id: <4785088A.2070601@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
 <477BEFF1.2090507@sun.com> <4784D86C.1070503@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> Currently the root window drawable is labeled s0 which is system low 
> but it seems like it should be system high (s15:c0.c1023).

We treat it as system low to make screen snapshots and animations work 
properly. It also provides better integrity. Why should it be system high?

I think you want to make a distinction between the root drawable (as a 
viewable image) and as a conduit for event notification. In our 
implementation the drawable is system low, but the label for sending 
events to the root window is essentially system high. Anyone can send an 
event to the root window, but these events are only delivered to TCB 
clients. The ability to express interest in such events is restricted.

We also have a fairly complex policy on labeling the root colormap in 
which each color cell is independently labeled. This is an artifact of 
the graphics hardware we supported (8bit color maps).

>
> As for polyinstantiating properties I've been looking at dix property, 
> xace and xselinux and thinking about how it could be done. Looking at 
> property.c it seems like FindProperty would be the logical place to 
> search for properties based on name, context and probably a list of 
> singleton root window properties (as Glenn mentions). Currently 
> FindProperty doesn't use XaceHook and it is unclear whether 
> XACE_PROPERTY_ACCESS would be the right hook. Also other functions, 
> ProcGetProperty, don't use FindProperty to find properties.
> Regarding the idea of setting the context when a property is written 
> this would only be feasible when the mode was PropModeReplace. Even if 
> this were deemed a reasonable approach there'd probably still be a 
> list of singleton root window properties that writers could not change 
> the context of.
> We really need a solution to the issue of polyinstantiated properties 
> or there is no way X apps will run in MLS enforcing mode.
>
We implemented this before XACE was developed. I think a new hook is 
required.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
