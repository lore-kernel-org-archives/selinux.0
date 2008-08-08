Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78KF1Kw020517
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 16:15:01 -0400
Subject: Re: Gconf application
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: shaunak saha <reach.shaunak@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <d74d42a50808080715k5cc752acy3bad72465baaa5c0@mail.gmail.com>
References: <d74d42a50808080715k5cc752acy3bad72465baaa5c0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 16:15:23 -0400
Message-Id: <1218226523.22894.42.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-08-08 at 19:45 +0530, shaunak saha wrote:
> Hi all,
>  
> I m new to selinux.I am not sure I am posing this question correctly,
> so please view it
> from the perspective of where I am trying to get to.
>  
> I need to protect Gconf applications.I have two client applications
> running in different domains.From the policy file one applcation
> should be allowed to do operations in GConf while other should only be
> able to read from Gconf.
> For this i m planning to follow the NSA whitepaper i found from
> net(http://www.nsa.gov/seLinux/papers/gconf07-abs.cfm) and creating a
> userspace
> object manager.Is that the correct approach or there is any other way
> to make selinux checks for gconf applications?
> 
> FYI:I m using gconf-dbus,not the orbit gconf.
>  

That work is old. I hope to update it someday, but it will take some
work for you to update it to the latest GConf.  The patch is a little
big to send to the list, but I can send it to you, or make it available
somewhere if there is interest from others as well.

I think that you have to make gcond a userspace object manager to do
what you want.  You want both applications to be able to send requests
to gconfd and to receive replies, so they both must be able to send and
receive messages to gconfd through D-Bus.  While D-Bus allows control
over who can use a bus name, and it will control the sending and
receiving of messages between the two processes, I don't think that you
can use it to control access to specific methods. You would need it to
prevent the one application from using the "set" method (or whatever it
is called).  

One good thing about using D-Bus though is that you can have gconfd use
the "GetConnectionSELinuxSecurityContext" method to get the client's
security context from D-Bus.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
