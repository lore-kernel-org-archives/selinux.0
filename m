Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MNUIvN028173
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 18:30:18 -0500
Message-ID: <47BF5B06.3040108@tycho.nsa.gov>
Date: Fri, 22 Feb 2008 18:30:14 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: So how would I write policy with xace/XSELinux to stop xspy from
 working?
References: <47BDE1A9.7090908@redhat.com>
In-Reply-To: <47BDE1A9.7090908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> http://www.acm.vt.edu/~jmaxwell/programs/xspy/xspy.html
>
> I want to lauch gnome-screensaver with a different context and not let
> xspy grab the password.
>   

Unfortunately, putting gnome-screensaver into a separate context cannot 
solve this problem.  xspy works by directly reading the state of the 
keyboard using XQueryKeymap().  The location of the input focus does not 
matter to this call; this is by design of the X protocol.

The solution has to be globally denying "read" permission on the default 
keyboard device.  The vast majority of apps should never need this 
permission because the proper way to receive input is to passively wait 
for input events on your own windows, not to go out and actively query 
device state in this manner.

I tried this just now and it stopped xspy cold.  However, there may need 
to be some refinement of the controls in this area.  In particular, 
XQueryPointer() also requires "read" permission and this seems to be 
more frequently called, e.g. by toolkit libraries, even though it really 
is snooping; you can likely determine a lot just by knowing the 
movements of the mouse.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
