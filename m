Message-ID: <464B3A6F.40000@redhat.com>
Date: Wed, 16 May 2007 13:07:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: James Antill <jantill@redhat.com>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: In FC8 I would like to start playing with trusted X.
References: <4649FFA2.9060701@redhat.com> <1179326483.16624.21.camel@code.and.org> <464B2F95.7090700@redhat.com> <464B386D.3060000@tycho.nsa.gov>
In-Reply-To: <464B386D.3060000@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Daniel J Walsh wrote:
>> Ok now I was hoping the NSA guys would hop in and say.  Hey here is 
>> how you would do it.  :^)
>> Because I have no idea.  Any help would be appreciated.
>
> I've been slowly reviewing all of the 35 X protocol extensions of 
> which I'm aware, trying to revise the set of object classes and 
> permissions. I have about 8 more extensions to go.  I'm hoping to do a 
> major release of the security framework and Flask module before FC8.
>
> I think the two goals you have set forth are a reasonable target.  The 
> input goal I don't think is possible with the current implementation, 
> because the input extensions (XKB, XInput) are not covered by the 
> security hooks.  The screenshot goal should be possible.  There are 
> many screenshot apps but they all should call XCopyImage or similar, 
> which are controllable.  The problem is that the screenshot app gets a 
> BadAccess error from the denial and Xlib calls abort; it's not very 
> graceful.
>
That is what I figured.  And in order to get upstream of Xorg to fix 
these problems, we have to start showing usefulness of the access control.


>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
