Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5SETi4H004556
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 10:29:45 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5SETigj026175
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 14:29:44 GMT
Received: by an-out-0708.google.com with SMTP id d30so675157and.75
        for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 07:29:44 -0700 (PDT)
Message-ID: <48664AD4.1010904@gmail.com>
Date: Sat, 28 Jun 2008 09:29:40 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: window manager policy
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com> <4859A64C.7050705@tycho.nsa.gov> <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com> <4865AED6.9020404@tycho.nsa.gov>
In-Reply-To: <4865AED6.9020404@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Joe Nall wrote:
>>
>> What other desktop related processes need MLS policies to be written  
>> to get a minimally functional Fedora/Gnome enforcing X environment?
>>
>> What window manager/environment do you use in your enforcing X  
>> development and test?
>>   
>
> Many AVC's I'm getting are caused by the fact that the server starts 
> up as xdm_xserver_t:
>
> allow sysadm_t xdm_rootwindow_t:x_colormap { use install uninstall };
> allow sysadm_t xdm_rootwindow_t:x_drawable { get_property show read 
> manage add_child remove_child list_child hide setattr receive 
> set_property create send write
> allow sysadm_t xdm_xserver_t:x_device { setfocus use setattr grab 
> manage getattr freeze };
> allow sysadm_t xdm_xserver_t:x_screen { saver_setattr saver_getattr 
> setattr };
> allow sysadm_t xdm_xserver_t:x_server manage;
>
>
> ...and xdm_t windows are apparently still open on the display when the 
> user's gnome-session is run:
>
> allow sysadm_t xdm_t:x_client destroy;
> allow sysadm_t xdm_t:x_drawable { get_property receive getattr 
> list_child };
> allow sysadm_t xdm_xproperty_t:x_property { write read };
>
>
>
> This week I attempted to write a prototype display manager that would 
> stop the X server and run a new one after the user logs in.  However 
> this process looks incredibly ugly and takes forever, and I'm also 
> having trouble with the X server not starting up at all some of the 
> time, so I've given up on that for now.
>
> I did get a patch into gdm this week though.  

What does the gdm mod do, restart the X server as the user?
> Once libxcb-selinux is released I'll be able to make patch for PAM to 
> have it relabel X server objects dynamically as part of pam_open_session.
>
> I'll take a look at the window manager policy next week.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
