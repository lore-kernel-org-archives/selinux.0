Message-ID: <1342546288.10747.14.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: Information about XSELinux
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Tue, 17 Jul 2012 13:31:28 -0400
In-Reply-To: <20120716161006.GA14824@telvanni>
References: <20120716161006.GA14824@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-16 at 18:10 +0200, Ole Kliemann wrote:
> Hi everyone!
> 
> I'm desperately trying to implement proper privilege seperation 
> while using X.
> 
> Currently I'm looking into XSELinux but am having a really hard 
> time finding any information, documention etc.
> 

Some of this could be out of date, but it should get you started.

http://www.nsa.gov/research/_files/selinux/papers/xorg07-abs.shtml
http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.html
http://selinuxproject.org/page/NB_XWIN
http://selinuxproject.org/page/Experimenting_With_X-Windows#Calling_the_XSELinux_Functions

> What's the development status?
> Where can I get it?
> Is it included in any major distributions? (Currently using 
> Ubuntu 12.04)
> 

It is in Fedora.
Enable the xserver_object_manager_boolean (setsebool -P
xserver_object_manager=1) and restart the X server.

The file /etc/selinux/POLICY/contexts/x_contexts contains an X event to
context mapping.

The xserver module contains the current policy for the X server.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
