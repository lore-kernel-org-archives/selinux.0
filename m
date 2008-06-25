Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PJKb1h027228
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:20:37 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PJKahq004496
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 19:20:36 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1404545fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 12:20:35 -0700 (PDT)
Message-ID: <cadfc0e40806251220s6bfce4b3j444b33e9705aa488@mail.gmail.com>
Date: Wed, 25 Jun 2008 14:20:35 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: window manager policy
Cc: "Joe Nall" <joe@nall.com>, "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <485FDAEC.7010807@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com>
	 <4859A64C.7050705@tycho.nsa.gov>
	 <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com>
	 <485FDAEC.7010807@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 23, 2008 at 12:18 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Joe Nall wrote:
>>
>> On Jun 18, 2008, at 7:20 PM, Eamon Walsh wrote:
>>
>>
>>>
>>> Xavier Toth wrote:
>>>
>>>>
>>>> I'm contemplating some AVC's that originate in metacity and am
>>>> wondering whether a window manager is a special case of an X client
>>>> that requires its' own policy. Are there things that a window manager
>>>> does that other X clients shouldn't? Also on an MLS system should the
>>>> window manager run at the users highwater mark or ranged?
>>>>
>>>>
>>>
>>> The window manager basically needs the full run of the display.   When
>>> another application creates a window, the window manager  creates a second
>>> window with the titlebar and borders, and then  plops the application window
>>> down inside of it (reparents it).  It  also moves windows around and resizes
>>> them, sets properties on them  (such as the _NET_WM_DESKTOP property that
>>> contains the desktop  number) and listens for events so it can tell when to
>>> change the  focus window.  Finally, a compositing manager actually needs to
>>> read  the window contents.  It's definitely a special-case app that's  going
>>> to need its own policy.
>>>
>>> It almost certainly needs permissions on all windows that map to  both
>>> read and write in the MLS configuration.  So it will need read-  and
>>> write-all-levels.
>>>
>>
>> What other desktop related processes need MLS policies to be written  to
>> get a minimally functional Fedora/Gnome enforcing X environment?
>>
>
> Don't know for sure...but probably gnome-session (starts up processes),

After working on an initial window manager policy I've been thinking
about how it is started by gnome-session and whether it should be run
at the users clearance, what does everyone think?

> nautilus and gnome-panel (can be used to launch processes; gnome-panel
> interacts with small applet windows that are inside it).
>
>> What window manager/environment do you use in your enforcing X
>>  development and test?
>>
>
> I have one machine where I compile the full Xorg distribution, policy, and a
> few other things (pam, gdm) from scratch.  I just finished setting up
> another machine that runs Fedora 9, with just refpolicy and XCB compiled
> from source.  This should make it easier for me to develop and test policy.
>  It's just running regular GNOME, although I may install XFCE on it as well.
>
>> Do you have a start on a window manager policy that we could try?
>>
>
> It should be transitioned into a domain that has unconfined TE perms over X
> objects, and is MLS trusted.  After that it's a matter of seeing what
> permissions regular applications need over window-manager created windows,
> particularly decoration windows.  They might need some permissions over the
> window manager's windows since they might try to manipulate the
> window-manager "decoration" windows that their own app window is reparented
> into.  To deal with this, I think that the window manager is going to need
> to call SetWindowCreateContext to put window decorations into the same
> context as the associated application window.  I'm hoping to try and make a
> patch to do this, this week.
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
