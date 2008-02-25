Message-ID: <47C2D552.8060509@redhat.com>
Date: Mon, 25 Feb 2008 09:48:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil> <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Mon, 2008-02-25 at 09:12 -0500, Stephen Smalley wrote:
>> On Mon, 2008-02-25 at 09:09 -0500, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> If I turn on xserver_object_manager in rawhide and log in as staff_t in
>>> permissive mode, I get all sorts of things failing, which makes writing
>>> policy for it very difficult.  And is very broken.
>> Hmmm...as I understood it, XSELinux should follow the kernel's enforcing
>> status by default (i.e. if the kernel is permissive, then so should
>> XSELinux), unless you explicitly configure enforcing= in xorg.conf to
>> specify a different setting for the X server than the kernel.  You are
>> supposed to be able to make the X server permissive w/o making the
>> kernel permissive via xorg configuration, I believe, although I'm not
>> sure that made it into the rawhide xorg yet.
> 
> Doesn't look like the rawhide xorg server has that support yet.
> 
> But it should follow the kernel's enforcing status.  You should see log
> messages with "received setenforce notice (enforcing=...)" in them from
> both dbus and X in either /var/log/messages or /var/log/audit/audit.log.
> 
Looking at the code, I do not see security_getenforce() in the code.
Are you saying that this is not necessary, the kernel will return
allowed but generate the AVC?

And the only one who mentions setenforce in /var/log/audit/audit.log in
dbus not X?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfC1VIACgkQrlYvE4MpobMGbgCgsApumkxRzzo21JtgjE8S1psc
GpQAoNt6178sE4a0tWpICiErtJw1MzqH
=ZTuN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
