Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5J0KT7o014329
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 20:20:29 -0400
Message-ID: <4859A64C.7050705@tycho.nsa.gov>
Date: Wed, 18 Jun 2008 20:20:28 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: window manager policy
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com>
In-Reply-To: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I'm contemplating some AVC's that originate in metacity and am
> wondering whether a window manager is a special case of an X client
> that requires its' own policy. Are there things that a window manager
> does that other X clients shouldn't? Also on an MLS system should the
> window manager run at the users highwater mark or ranged?
>   

The window manager basically needs the full run of the display.  When 
another application creates a window, the window manager creates a 
second window with the titlebar and borders, and then plops the 
application window down inside of it (reparents it).  It also moves 
windows around and resizes them, sets properties on them (such as the 
_NET_WM_DESKTOP property that contains the desktop number) and listens 
for events so it can tell when to change the focus window.  Finally, a 
compositing manager actually needs to read the window contents.  It's 
definitely a special-case app that's going to need its own policy.

It almost certainly needs permissions on all windows that map to both 
read and write in the MLS configuration.  So it will need read- and 
write-all-levels.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
