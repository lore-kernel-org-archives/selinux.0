Message-ID: <47C42390.9050607@redhat.com>
Date: Tue, 26 Feb 2008 09:34:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>	 <47C2D552.8060509@redhat.com> <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil> <47C316EF.5090206@redhat.com> <47C3261C.1070508@tycho.nsa.gov> <47C36767.7030503@tycho.nsa.gov>
In-Reply-To: <47C36767.7030503@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eamon Walsh wrote:
> Eamon Walsh wrote:
>> The X object manager logs all avc's and status messages (including the
>> AVC netlink stuff) through the audit system using libaudit calls
>> (audit_log_user_avc_message, etc.)   I disavow all responsibility for
>> the messages once they enter libaudit
> 
> It's being black-holed in rawhide.  To see for yourself, add the
> attached patch to the spec file and rebuild the xserver from SRPM.  It
> will tee the avc messages into /var/log/Xorg.0.log.
> 
> Also, pull libselinux from upstream.  The BadWindow error may be fixed.
> 
> You'll have to report to me what you see in the X server output.  I'm
> seeing tons of avc's: it doesn't appear as though staff_t is even
> getting X permissions allowed.
> 
> 
> 
> 
> 
My current rawhide policy is available at


http://people.fedoraproject.org/~dwalsh/SELinux/F9/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfEI5AACgkQrlYvE4MpobNueACeLHwWDZVdB9zHEF+oCOx2aDJR
ujEAn17mGB7k26icF3bLpSjY7PxW8PvT
=WmDN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
