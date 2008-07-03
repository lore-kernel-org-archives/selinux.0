Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m63KYsY6000988
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 16:34:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m63KYrYW002862
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 20:34:54 GMT
Message-ID: <486D37BB.2030508@redhat.com>
Date: Thu, 03 Jul 2008 16:34:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: gnome-screensav AVCs
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>	 <1213717150.11146.88.camel@gorn> <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com>
In-Reply-To: <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
> On Tue, Jun 17, 2008 at 10:39 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>> On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
>>> I'm seeing AVCs related to netlink_audit_socket when the screen saver
>>> dialog is run. gnome-screensaver-dialog opens a pam session which uses
>>> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
>>> gnome-screensaver-dialog is going to need some policy including
>>> possibly authlogin_common_auth_domain_template.
>> I'm not 100% clear, is the auditing happening from unix_chkpwd or the
>> screensaver proper?
>>
> 
> I'm sure that it is unix_chkpwd that is auditing and not
> gnome-screensaver-dialog.
> 
>>> Would it be best to add policy for this to gnome or should it have
>>> it's own module?
>> The gnome module is for policies for core gnome components.
>> Unfortunately "core component" isn't really well defined at the moment.
>> But I've been thinking about it since Dan has a gnome clock applet
>> policy since it can set the clock.  If we had a better idea what pieces
>> needed their own domain, it'd be easier to make a decision.  Something
>> like dbus doesn't fit since its useful outside of gnome.
> 
> Yes there may be other gnome apps that need policy but I don't know
> which at this point.
> 
>> --
>> Chris PeBenito
>> Tresys Technology, LLC
>> (410) 290-1411 x150
>>
>>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
It is the pam library that is calling audit_open, which triggers this
avc.  You need to dontaudit it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhtN7sACgkQrlYvE4MpobM8PACbBbESdnuEbdlT6u1fhyiWDSj3
hkQAnRYuulCW0b2GfcPbbnOzxXqn92CI
=4478
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
