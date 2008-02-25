Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PJYj1Q023685
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:34:45 -0500
Message-ID: <47C31800.4020805@tycho.nsa.gov>
Date: Mon, 25 Feb 2008 14:33:20 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: So how would I write policy with xace/XSELinux to stop xspy from
 working?
References: <47BDE1A9.7090908@redhat.com> <47BF5B06.3040108@tycho.nsa.gov> <47BF63B2.9030406@redhat.com> <47C2D2BB.7040303@redhat.com>
In-Reply-To: <47C2D2BB.7040303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Daniel J Walsh wrote:
>   
>> Eamon Walsh wrote:
>>     
>>> Daniel J Walsh wrote:
>>>       
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> http://www.acm.vt.edu/~jmaxwell/programs/xspy/xspy.html
>>>>
>>>> I want to lauch gnome-screensaver with a different context and not let
>>>> xspy grab the password.
>>>>   
>>>>         
>>> Unfortunately, putting gnome-screensaver into a separate context cannot
>>> solve this problem.  xspy works by directly reading the state of the
>>> keyboard using XQueryKeymap().  The location of the input focus does not
>>> matter to this call; this is by design of the X protocol.
>>>       
> Are you talking about a physical device in /dev?   Or some X device?
>   

The "virtual core keyboard" device, which is an internal X device.  All 
the old "core" X protocol, from the old days where there was just one 
keyboard and one mouse, refers to this device as simply "the keyboard."

 From the X11 Protocol Specification:

QueryKeymap: This request returns a bit vector for the logical state of 
the keyboard.  Each bit set to 1 indicates that the corresponding key is 
currently pressed.  The vector is represented as 32 bytes.  Byte N (from 
0) contains the bits for keys 8N to 8N + 7 with the least significant 
bit in the byte representing key 8N.  Note that the logical state of a 
device (as seen by means of the protocol) may lag the physical state if 
device event processing is currently frozen.

If you read the source for xspy, it's simply a loop around this 
function, calling it over and over.



> What policy did you write to test this?
>   

I took the refpolicy "xselinux" branch, removed "read" permission from 
the set of permissions granted on X devices, ran an X server in 
enforcing mode and an xterm, and then ran xspy and tried typing into the 
xserver.  xspy didn't do anything except generate 100 avc's per second 
(the rate at which it calls XQueryKeymaq).


>>> The solution has to be globally denying "read" permission on the default
>>> keyboard device.  The vast majority of apps should never need this
>>> permission because the proper way to receive input is to passively wait
>>> for input events on your own windows, not to go out and actively query
>>> device state in this manner.
>>>       
>>> I tried this just now and it stopped xspy cold.  However, there may need
>>> to be some refinement of the controls in this area.  In particular,
>>> XQueryPointer() also requires "read" permission and this seems to be
>>> more frequently called, e.g. by toolkit libraries, even though it really
>>> is snooping; you can likely determine a lot just by knowing the
>>> movements of the mouse.
>>>       
>> Well it seems like all confined domains should have the read on the
>> keyboard blocked, then and maybe unconfined_t by boolean.
>>     
>
> - --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkfC0rsACgkQrlYvE4MpobOoawCdGDxDHq1ONqlwY4eLEox9uUra
> 8MUAn2Z3tw+zKvnnfXu2i2fIY7yCbM/S
> =x/sk
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
