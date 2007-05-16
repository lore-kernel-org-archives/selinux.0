Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4GLwFRr006469
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2007 17:58:15 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4GLwG7A008279
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2007 21:58:16 GMT
Received: by an-out-0708.google.com with SMTP id c10so87403ana
        for <selinux@tycho.nsa.gov>; Wed, 16 May 2007 14:58:16 -0700 (PDT)
Message-ID: <464B78CB.4080107@gmail.com>
Date: Wed, 16 May 2007 16:34:03 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: In FC8 I would like to start playing with trusted X.
References: <4649FFA2.9060701@redhat.com> <1179326483.16624.21.camel@code.and.org> <464B2F95.7090700@redhat.com> <464B386D.3060000@tycho.nsa.gov> <464B3A6F.40000@redhat.com> <464B49F6.7010009@tycho.nsa.gov>
In-Reply-To: <464B49F6.7010009@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Daniel J Walsh wrote:
>> Eamon Walsh wrote:
>>> Daniel J Walsh wrote:
>>>> Ok now I was hoping the NSA guys would hop in and say.  Hey here is 
>>>> how you would do it.  :^)
>>>> Because I have no idea.  Any help would be appreciated.
>>> I've been slowly reviewing all of the 35 X protocol extensions of 
>>> which I'm aware, trying to revise the set of object classes and 
>>> permissions. I have about 8 more extensions to go.  I'm hoping to do 
>>> a major release of the security framework and Flask module before FC8.
>>>
>>> I think the two goals you have set forth are a reasonable target.  
>>> The input goal I don't think is possible with the current 
>>> implementation, because the input extensions (XKB, XInput) are not 
>>> covered by the security hooks.  The screenshot goal should be 
>>> possible.  There are many screenshot apps but they all should call 
>>> XCopyImage or similar, which are controllable.  The problem is that 
>>> the screenshot app gets a BadAccess error from the denial and Xlib 
>>> calls abort; it's not very graceful.
>>>
>> That is what I figured.  And in order to get upstream of Xorg to fix 
>> these problems, we have to start showing usefulness of the access 
>> control.
>
>
> I have some ideas for demos to show the usefulness of the controls. 
> Basically bring up a graffiti program that draws on other windows and 
> show how it can be selectively stopped.  Same thing with a program 
> that monitors keyboard input.  This doesn't have to be SELinux-based, 
> it could be a simple DAC module with permission buttons on the window 
> title bar.  Just as soon as I finish my Big Spreadsheet of X Protocol 
> and implement the support for the extensions...
>
> Upstream Xorg is not really the problem though.  The new XCB libraries 
> have support for proper error handling.  The problem is getting the 
> toolkits and applications, GTK+ etc. to switch over from Xlib and/or 
> actually check for errors on every request.
>
>
What is the current status of the xserver policy? Has it been upstreamed?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
