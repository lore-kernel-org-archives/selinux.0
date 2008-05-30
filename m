Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4UNAX8v012669
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 19:10:33 -0400
Message-ID: <48408967.7060104@tycho.nsa.gov>
Date: Fri, 30 May 2008 19:10:31 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Xavier Toth <txtoth@gmail.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rbacsep: collapsing xserver
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>	 <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>	 <483DA6AF.1070807@redhat.com>	 <cadfc0e40805300619l5feb8dddj7efb9f9797e3e9c3@mail.gmail.com>	 <1212155223.31546.42.camel@gorn> <ddbc00640805300801y65fb769u510cea3b1fe3c815@mail.gmail.com>
In-Reply-To: <ddbc00640805300801y65fb769u510cea3b1fe3c815@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> On Fri, May 30, 2008 at 8:47 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>   
>> On Fri, 2008-05-30 at 08:19 -0500, Xavier Toth wrote:
>>     
>>> On Wed, May 28, 2008 at 1:38 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>>       
>>>> The current XAce software is far to complex to do anything usefull in my
>>>> opinion.  We have way too many types and transitions.  We need to
>>>> simplify down to a lot less types.
>>>>         
>>> Going back to Dan's concern about the complexity of the X SELinux
>>> extension and the number of types and transitions I'd like to see some
>>> discussion/resolution. Eamon what's your position on this topic?
>>>       
>> I don't want to speak for Eamon, but I suspect that he would defend the
>> current setup since he's the one that wrote the policy.  I just
>> restructured it to fit nicer in refpolicy and actually removed a few
>> types :)
>>
>> My position is that its fine as is.  Simplifying it unconditionally
>> starts to make it less usable for people that actually want fine grained
>> controls on the desktop.  Making things simpler tends to be easy, since
>> it tends to be merging types or using attributes for blanket access,
>> like unconfined does.  The black magic voodoo that happens in the
>> xserver, that only a select few have previously known about, has only
>> recently been exposed via the SELinux controls.  I feel that it may be
>> premature to simplify the policy, since side effects probably aren't
>> well understood yet.  At least they aren't understood well by me yet.
>>     

I never signed up to write "the SELinux policy" for X.  It is my 
responsibility to document my work so that others can write such 
policies, and I will do so.  See my earlier private message (pasted below).

X policy will be an area where one size doesn't fit all.  I'll try to 
address the concerns in the "current diff" mail.

>
> I can relate to that :)
>
> Voodoo note: Any post-login setuid magic will have to allow the
> xserver object manager to continue to audit.
>
>   

Changing the UID isn't all that interesting to me; it's changing the 
context that matters.  If SDTLOGIN or pam_selinux.so could be used to 
implement a setcon() solution, great.  If we could launch the server 
after the user logs in, even better.

> I chimed in on this thread because we need to get MLS X up and running
> locally in enforcing mode. I wanted to make sure that we (Ted and I)
> understood the issues involved as much as possible before changing any
> policy.
>   

The documentation links in the pasted message below are the best way to 
get started with understanding X.

---

I plan to get some documentation into shape for the upcoming X server 
release.  This will certainly include updated XACE hook documentation, 
as well as rudimentary one-liner class and permission documentation that 
can go in the table of classes and permissions I recall seeing somewhere 
(but can't find at the moment).  The only thing I have right now is a 
large spreadsheet of X protocol requests and the permissions required 
for each one.  I will do my best to make sure this knowledge gets put 
into a communicable form.

However, it is time for other people in this community besides myself to 
start figuring how X works.  The X Window System is not black magic; the 
core X protocol is described at [1] and many of the X extensions 
(additional calls that have been added over the years) are described at 
[2].  A great place to start would be the Xlib programming manual [3].  
Wikipedia also has pages on many of the popular extensions.  After that, 
the various conventions that have been established for using X: the 
ICCCM, which describes the cut & paste protocol and other aspects of how 
window managers work [4].  The NETWM standard, its successor [5].  The 
XSETTINGS selection protocol [6].  Finally, all of the GNOME and KDE 
conventions and non-conventions (which I do not understand, because I 
have not gotten that far) and the requirements of the various "core" 
desktop applications such as nautilus, gnome-panel, gnome-session, gdm, 
gnome-screensaver, gnome-power-manager, gnome-keyring, etc.

People just know how files, symbolic links, pipes, and sockets work, and 
they do not need Steve to explain this to them.   X should not be any 
different.


[1] http://cgit.freedesktop.org/xorg/doc/xorg-docs/tree/hardcopy/XProtocol
[2] http://cgit.freedesktop.org/xorg/doc/xorg-docs/tree/hardcopy/Xext
[3] http://cgit.freedesktop.org/xorg/doc/xorg-docs/tree/hardcopy/X11
[4] http://cgit.freedesktop.org/xorg/doc/xorg-docs/tree/hardcopy/ICCCM
[5] http://freedesktop.org/wiki/Specifications/wm-spec?action=show&redirect=Standards%2Fwm-spec
[6] http://standards.freedesktop.org/xsettings-spec/xsettings-spec-0.5.html


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
