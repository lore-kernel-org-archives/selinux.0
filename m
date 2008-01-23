Message-ID: <47979DCB.20203@redhat.com>
Date: Wed, 23 Jan 2008 15:04:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to install selinux python with correct permissions.
References: <47834E2C.4070303@redhat.com> <1201096319.7025.264.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201096319.7025.264.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2008-01-08 at 05:19 -0500, Daniel J Walsh wrote:
>> plain text document attachment (diff)
>> diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.46/src/Makefile
>> --- nsalibselinux/src/Makefile	2007-09-26 19:37:45.000000000 -0400
>> +++ libselinux-2.0.46/src/Makefile	2008-01-05 08:19:27.000000000 -0500
>> @@ -77,14 +77,14 @@
>>  
>>  install: all 
>>  	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
>> -	install -m 644 $(LIBA) $(LIBDIR)
> 
> Why remove the static library from the install target?  We still want it
> installable via some target.
> 
Yes we should not do this.
>>  	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
>>  	install -m 755 $(LIBSO) $(SHLIBDIR)
>>  	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
>>  
>>  install-pywrap: pywrap
>>  	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
>> -	install -m 755 $(SWIGFILES) $(PYTHONLIBDIR)/site-packages
>> +	install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages
>> +	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages
> 
> So is there much point in keeping SWIGFILES around then?  Also used in
> clean: at present, but that's the only remaining use.   And presumably
> the same change should happen to libsemanage?
>
I don't think so.  I would remove them and spell it out.

>>  relabel:
>>  	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeXncsACgkQrlYvE4MpobOx1wCgrqcLDl4mtY7Yf6biBsbmuLEy
830An2LE/elmxj8/VBZhLV0UxJmmp2Q2
=Z3kZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
