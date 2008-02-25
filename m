Message-ID: <47C3212B.3090204@redhat.com>
Date: Mon, 25 Feb 2008 15:12:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>	 <47C2D552.8060509@redhat.com> <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil> <47C316EF.5090206@redhat.com>
In-Reply-To: <47C316EF.5090206@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> On Mon, 2008-02-25 at 09:48 -0500, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Stephen Smalley wrote:
>>>> On Mon, 2008-02-25 at 09:12 -0500, Stephen Smalley wrote:
>>>>> On Mon, 2008-02-25 at 09:09 -0500, Daniel J Walsh wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>>
>>>>>> If I turn on xserver_object_manager in rawhide and log in as staff_t in
>>>>>> permissive mode, I get all sorts of things failing, which makes writing
>>>>>> policy for it very difficult.  And is very broken.
>>>>> Hmmm...as I understood it, XSELinux should follow the kernel's enforcing
>>>>> status by default (i.e. if the kernel is permissive, then so should
>>>>> XSELinux), unless you explicitly configure enforcing= in xorg.conf to
>>>>> specify a different setting for the X server than the kernel.  You are
>>>>> supposed to be able to make the X server permissive w/o making the
>>>>> kernel permissive via xorg configuration, I believe, although I'm not
>>>>> sure that made it into the rawhide xorg yet.
>>>> Doesn't look like the rawhide xorg server has that support yet.
>>>>
>>>> But it should follow the kernel's enforcing status.  You should see log
>>>> messages with "received setenforce notice (enforcing=...)" in them from
>>>> both dbus and X in either /var/log/messages or /var/log/audit/audit.log.
>>>>
>>> Looking at the code, I do not see security_getenforce() in the code.
>>> Are you saying that this is not necessary, the kernel will return
>>> allowed but generate the AVC?
>> Handling of enforcing status is hidden within the userspace AVC in
>> libselinux (libselinux/src/avc*.c).  avc_enforcing stores the current
>> value of the enforcing status and is updated when the kernel generates
>> the setenforce notification.  avc_setenforce is set if the object
>> manager explicitly sets its own enforcing mode to a specific value to
>> override the kernel status.
> 
>>> And the only one who mentions setenforce in /var/log/audit/audit.log in
>>> dbus not X?
>> Hmmm...that's seems like a bug in X then, that it isn't getting the
>> notifications from the kernel (via netlink).
> 
> Yes XAce seems to be very broken in Rawhide.  Enforcing mode was working
> until I fixed the policy to allow xserver to talk to /selinux and run
> the validation routines.  Now xace is blowing up both in permissive and
> enforcing mode.
> 
> Trying to start nm-applet is getting a BadWindow error.
> 
> If you update to todays rawhide and try to login in permissive mode,
> metacity and gconf will blow up.
> 

nm-applet --sync
The program 'nm-applet' received an X Window System error.
This probably reflects a bug in the program.
The error was 'BadWindow (invalid Window parameter)'.
  (Details: serial 228 error_code 3 request_code 2 minor_code 0)
  (Note to programmers: normally, X errors are reported asynchronously;
   that is, you will receive the error a while after causing it.
   To debug your program, run it with the --sync command line
   option to change this behavior. You can then get a meaningful
   backtrace from your debugger if you break on the gdk_x_error() function.)


This is a serious problem, and needs to be fixed ASAP, or I need to pull
support for xace from policy.

This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfDISsACgkQrlYvE4MpobMlYQCggrKUB4HabHGsMwLfG5+nB18i
G5UAnRWiQ2AGGaGczhK5czqVg4tbHmmp
=26fF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
