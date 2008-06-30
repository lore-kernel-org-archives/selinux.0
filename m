Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UIIZuU010247
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 14:18:35 -0400
Message-ID: <48692379.402@tycho.nsa.gov>
Date: Mon, 30 Jun 2008 14:18:33 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: X in enforcing mode
References: <5B8DD16C-FED5-45C9-8032-9760F2C165C9@nall.com>
In-Reply-To: <5B8DD16C-FED5-45C9-8032-9760F2C165C9@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> In order to get firefox, evolution and xterm to run under twm with the  
> X object manager in enforcing/mls at a single level I had to add the  
> following user policy:
>
>          allow $1_t $1_rootwindow_t:x_drawable { get_property getattr  
> read override hide send destroy remove_child };
>          allow $1_t $1_xserver_t:x_resource write;
>
> Where $1 is user
>
> xinit was started by hand at init 3.
>
> Not being an X guy, I don't really understand what I just allowed.  
> Does this make sense?
>   

I can take a look at it if you send the original AVC's.  I'm assuming 
for the moment that twm is running in $1_t.

At first glance, everything seems normal, although the fact that 
something (hopefully the window manager) is requesting "destroy", 
"hide", and "override" on the root window is kind of odd.  "Read" 
permission should only be granted to the window manager, since it allows 
a screen-shot to be taken.  The x_resource object class is a generic 
fallback for any X object that doesn't have its own object class - I'd 
need to see the AVC to see what's going on there.

The other permissions are normal and safe to grant.  Briefly:

"get_property" allows the app to read properties on the root window.
"getattr" allows the app to query the size of the root window or other 
attributes.
"send" allows the app to send an event to the root window (this is done 
as part of some ICCCM conventions for communicating with the window 
manager).
"remove_child" allows the app to destroy its own windows when it's done.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
