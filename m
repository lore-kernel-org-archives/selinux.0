Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB5NbfFk027811
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 18:37:41 -0500
Message-ID: <457602C5.9050504@tycho.nsa.gov>
Date: Tue, 05 Dec 2006 18:37:41 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: XACE and MLS
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>	 <450962DB.7050107@tresys.com>	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>	 <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>	 <cadfc0e40611290712g7fa802f2oa5b5ebc079e8ead2@mail.gmail.com>	 <1164830966.2794.144.camel@moss-huskies.epoch.ncsc.mil>	 <cadfc0e40611291434w5b1468ffo2eb87b0e982569e2@mail.gmail.com> <1164857243.2794.177.camel@moss-huskies.epoch.ncsc.mil> <4575F6E9.1020600@gmail.com>
In-Reply-To: <4575F6E9.1020600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> We are interested in using X and an associated desktop/window manager 
> (most likely GNOME/Metacity) in an MLS environment and I'm trying to 
> figure out what all needs to be addressed to get there. A couple of 
> areas that I've thought about so far are window labeling and cut and 
> paste. For window labeling the window manager ought to be able to use 
> the context of it X server connection to decorate the window with the 
> level but what happens if for example a user does a newrole and changes 
> their level? 

The XSELinux extension provides window properties that can be used by 
the window manager in the same manner as the usual WM_NAME, WM_COMMAND, 
etc.  The one currently available is _SELINUX_CLIENT_CONTEXT which 
contains the domain of the connected process.  Others will be introduced 
in the future in particular _SELINUX_CONTEXT which will contain the 
context of the window itself.

Here's a screen shot of a hacked twm that displays this property in 
place of the usual window title:
http://people.freedesktop.org/~ewalsh/twm-demo.png

Note that what's really needed for proper labeling however is a 
server-controlled, secure area of the screen that clients can't draw 
into.  There could be spoofing attacks otherwise.

> For cut and paste dominance checks are needed would it be 
> reasonable to do these as an extension of the XACE and if so where can I 
> find out more about how to do this and if not where then?

It depends on which cut & paste.  The X server provides two methods: cut 
buffers, which are implemented as properties on the root window, and 
selections, which are implemented using a convoluted method of setting 
properties on client windows and sending notification events.  I believe 
that both of these methods should be securable using the XSELinux 
extension although ths work has not been done just yet.

Other cut & paste functionality may be provided by higher-level layers 
such as toolkits (GTK+) or desktop systems (GNOME, etc).  I have no 
knowledge of these areas.

A good reference for X cut & paste is the xlib.PS document in the 
xorg-docs package.  The basic SELinux X classes and permissions are 
described in the "Securing the X Window System with SELinux" paper on 
www.nsa.gov/selinux.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
