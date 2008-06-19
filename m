Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5K1l14o032737
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2008 21:47:01 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5K1l06n024406
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 01:47:00 GMT
Received: by yw-out-1718.google.com with SMTP id 6so538767ywa.84
        for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2008 18:47:00 -0700 (PDT)
Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Message-Id: <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com>
From: Joe Nall <joe@nall.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4859A64C.7050705@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: window manager policy
Date: Thu, 19 Jun 2008 18:12:07 -0500
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com> <4859A64C.7050705@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 18, 2008, at 7:20 PM, Eamon Walsh wrote:

> Xavier Toth wrote:
>> I'm contemplating some AVC's that originate in metacity and am
>> wondering whether a window manager is a special case of an X client
>> that requires its' own policy. Are there things that a window manager
>> does that other X clients shouldn't? Also on an MLS system should the
>> window manager run at the users highwater mark or ranged?
>>
>
> The window manager basically needs the full run of the display.   
> When another application creates a window, the window manager  
> creates a second window with the titlebar and borders, and then  
> plops the application window down inside of it (reparents it).  It  
> also moves windows around and resizes them, sets properties on them  
> (such as the _NET_WM_DESKTOP property that contains the desktop  
> number) and listens for events so it can tell when to change the  
> focus window.  Finally, a compositing manager actually needs to read  
> the window contents.  It's definitely a special-case app that's  
> going to need its own policy.
>
> It almost certainly needs permissions on all windows that map to  
> both read and write in the MLS configuration.  So it will need read-  
> and write-all-levels.

What other desktop related processes need MLS policies to be written  
to get a minimally functional Fedora/Gnome enforcing X environment?

What window manager/environment do you use in your enforcing X  
development and test?

Do you have a start on a window manager policy that we could try?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
