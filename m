Message-ID: <48FCE2BB.1010709@redhat.com>
Date: Mon, 20 Oct 2008 15:57:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Trying to figure out the signature of a screen capture.
References: <48F61C6A.6090703@redhat.com> <48F62519.8070805@tycho.nsa.gov> <48F64915.6030309@redhat.com> <48F65113.6090306@tycho.nsa.gov>
In-Reply-To: <48F65113.6090306@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eamon Walsh wrote:
> Daniel J Walsh wrote:
>> Eamon Walsh wrote:
>>> Daniel J Walsh wrote:
>>>> I wanted to see if we could prevent nsplugin_t from screen capturing
>>>> random parts of the Desktop.
>>>>
>>>> So I relabeled /usr/bin/gimp as nsplugin_exec_t, then ran it to get
>>>> AVC's, when capturing a screen image, sadly no AVC's were generated, so
>>>> nsplugin_t can capture screen images.
>>>>
>>>> I Wanted to see what avc's are created when you screen capture that are
>>>> different from running a standard X App, so I labeled /usr/bin/gimp and
>>>> put the machine in permissive mode.  Ran gimp to the point of capturing
>>>> the screen capture, and cleared the log files.
>>>>
>>>> When capturing the image I got the following allow rules.
>>>>
>>>> allow gpg_t focus_xevent_t:x_event receive;
>>>> allow gpg_t input_xevent_t:x_event receive;
>>>> allow gpg_t self:x_cursor destroy;
>>>> allow gpg_t xdm_rootwindow_t:x_drawable { read setattr };
>>>> allow gpg_t xdm_xserver_t:x_device { freeze force_cursor bell };
>>>>
>>>>
>>>> Is there anything we could eliminate from common X Apps, to prevent
>>>> nsplgugin from screen capture.
>>> It's "read" permission on the root window.  Remember that if you can
>>> read a window, you can read all of its children as well.  So having read
>>> on the root means you can see everything.
>>> Most apps shouldn't have this, and I don't see it granted in the current
>>> policy.  Actually I think GIMP launches a helper app to actually do the
>>> screencap.  I remember seeing its path in the AVC message.  So maybe
>>> that's why it's not working for you.
>>
>>
>> So are you saying.
>>
>> allow gpg_t xdm_rootwindow_t:x_drawable { read setattr };
>>
>> If, I don't allow this to apps, it would be blocked?
>>
>> Or some other
> 
> 
> Yes, if you disallow the "read" above then it should bomb out with a
> "BadAccess" error when you try to do the screenshot.
> 
> 

Sadly flashplugin required this in order to watch Sarah Palin on
Saturday Night Live.

allow nsplugin_t xdm_rootwindow_t:x_drawable read;

Maybe some one is trying to take a screen capture of Sarah?  :^)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkj84rsACgkQrlYvE4MpobPXWACfYDPg7LUgt++9hljqEIBtvx9o
Cp0AnAiMy3d5lX+G/G7TzMLGjGdr0Alg
=Wuog
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
