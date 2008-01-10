Date: Thu, 10 Jan 2008 15:55:35 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <47868AA4.5060102@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <4786B077.8060807@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
 <477BEFF1.2090507@sun.com> <4784D86C.1070503@gmail.com>
 <4785088A.2070601@sun.com> <47868AA4.5060102@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Glenn Faden wrote:
>>
>> We treat it as system low to make screen snapshots and animations 
>> work properly. It also provides better integrity. Why should it be 
>> system high?
>>
>> I think you want to make a distinction between the root drawable (as 
>> a viewable image) and as a conduit for event notification. In our 
>> implementation the drawable is system low, but the label for sending 
>> events to the root window is essentially system high. Anyone can send 
>> an event to the root window, but these events are only delivered to 
>> TCB clients. The ability to express interest in such events is 
>> restricted.
>>   
>
> I have to think about this some more, but currently there is no 
> separation between event destination and drawable in the SELinux model 
> - they are the same object.  The ability to read/write the drawable 
> and send/receive events are separate TE permissions.
>
> The contexts on the root window and root colormap are derived through 
> type transitions from the context of the X server process.  I think 
> the root window probably should be system-high, because without some 
> kind of censoring logic, if you can read the contents of a window in X 
> you can read all of its children as well.  Screenshot applications and 
> the window-manager animations should both be at system-high as well so 
> there wouldn't be a problem here, no?
The contents of the root window is typically irrelevant. In most modern 
desktops the root window is completely obscured by a desktop window and 
various panel windows. It should not be required to run a screenshot 
applications at system high unless you are trying to dump system high 
pixels. If you allow higher-level windows to overlap lower-level windows 
(as we do), then you must have some kind of censoring logic. In our case 
we blacken any row in which there are any exposed pixels which are not 
dominated by the label of the snapshot application. However, our 
convention of running separately labeled clients in separate workspaces 
permits fullscreen snapshots to be taken at the label of the workspace.
>
>> We also have a fairly complex policy on labeling the root colormap in 
>> which each color cell is independently labeled. This is an artifact 
>> of the graphics hardware we supported (8bit color maps).
>>   
>
> "Requested 84 colors, got 0."  Who can forget those days.  Anyway, the 
> original set of X security classes did have a "color" class that was 
> intended for individual color cells, however I dropped it in my 
> revision because I decided it would be too much work to fully secure 
> the colormap implementation given the fact that hardly anything uses 
> indexed-color mode anymore, and even things that do can just install 
> their own colormaps.
>
You're probably right, but you can use our code if you wish.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
