Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Message-Id: <85B608F8-EA9E-49D6-ADB4-BC5ECBB5D46B@nall.com>
From: Joe Nall <joe@nall.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4865AED6.9020404@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: window manager policy
Date: Fri, 27 Jun 2008 22:47:14 -0500
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com> <4859A64C.7050705@tycho.nsa.gov> <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com> <4865AED6.9020404@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 27, 2008, at 10:24 PM, Eamon Walsh wrote:

> Joe Nall wrote:
>>
>> What other desktop related processes need MLS policies to be  
>> written  to get a minimally functional Fedora/Gnome enforcing X  
>> environment?
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
> ...and xdm_t windows are apparently still open on the display when  
> the user's gnome-session is run:
>
> allow sysadm_t xdm_t:x_client destroy;
> allow sysadm_t xdm_t:x_drawable { get_property receive getattr  
> list_child };
> allow sysadm_t xdm_xproperty_t:x_property { write read };
>
>
>
> This week I attempted to write a prototype display manager that  
> would stop the X server and run a new one after the user logs in.   
> However this process looks incredibly ugly and takes forever, and  
> I'm also having trouble with the X server not starting up at all  
> some of the time, so I've given up on that for now.

What about creating a new X on another virtual terminal and switching  
to it?

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
