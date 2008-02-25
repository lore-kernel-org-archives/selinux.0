Message-ID: <47C2D2BB.7040303@redhat.com>
Date: Mon, 25 Feb 2008 09:37:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Ted X Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: So how would I write policy with xace/XSELinux to stop xspy from
 working?
References: <47BDE1A9.7090908@redhat.com> <47BF5B06.3040108@tycho.nsa.gov> <47BF63B2.9030406@redhat.com>
In-Reply-To: <47BF63B2.9030406@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
> Eamon Walsh wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> http://www.acm.vt.edu/~jmaxwell/programs/xspy/xspy.html
>>>
>>> I want to lauch gnome-screensaver with a different context and not let
>>> xspy grab the password.
>>>   
>> Unfortunately, putting gnome-screensaver into a separate context cannot
>> solve this problem.  xspy works by directly reading the state of the
>> keyboard using XQueryKeymap().  The location of the input focus does not
>> matter to this call; this is by design of the X protocol.
> 
Are you talking about a physical device in /dev?   Or some X device?
What policy did you write to test this?
>> The solution has to be globally denying "read" permission on the default
>> keyboard device.  The vast majority of apps should never need this
>> permission because the proper way to receive input is to passively wait
>> for input events on your own windows, not to go out and actively query
>> device state in this manner.
> 
>> I tried this just now and it stopped xspy cold.  However, there may need
>> to be some refinement of the controls in this area.  In particular,
>> XQueryPointer() also requires "read" permission and this seems to be
>> more frequently called, e.g. by toolkit libraries, even though it really
>> is snooping; you can likely determine a lot just by knowing the
>> movements of the mouse.
> 
> 
> Well it seems like all confined domains should have the read on the
> keyboard blocked, then and maybe unconfined_t by boolean.

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfC0rsACgkQrlYvE4MpobOoawCdGDxDHq1ONqlwY4eLEox9uUra
8MUAn2Z3tw+zKvnnfXu2i2fIY7yCbM/S
=x/sk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
