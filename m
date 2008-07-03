Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m63KaqXP001340
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 16:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m63KapYW003235
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 20:36:51 GMT
Message-ID: <486D3834.9080500@redhat.com>
Date: Thu, 03 Jul 2008 16:36:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Ted X Toth <txtoth@gmail.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: gnome-screensav AVCs
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>	 <1213717150.11146.88.camel@gorn>	 <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com>	 <1213723428.11146.93.camel@gorn>  <48580267.7000309@gmail.com> <1213727887.11146.97.camel@gorn>
In-Reply-To: <1213727887.11146.97.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Tue, 2008-06-17 at 13:28 -0500, Ted X Toth wrote:
>> Christopher J. PeBenito wrote:
>>> On Tue, 2008-06-17 at 10:55 -0500, Xavier Toth wrote:
>>>> On Tue, Jun 17, 2008 at 10:39 AM, Christopher J. PeBenito
>>>> <cpebenito@tresys.com> wrote:
>>>>     
>>>>> On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
>>>>>       
>>>>>> I'm seeing AVCs related to netlink_audit_socket when the screen saver
>>>>>> dialog is run. gnome-screensaver-dialog opens a pam session which uses
>>>>>> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
>>>>>> gnome-screensaver-dialog is going to need some policy including
>>>>>> possibly authlogin_common_auth_domain_template.
>>>>>>         
>>>>> I'm not 100% clear, is the auditing happening from unix_chkpwd or the
>>>>> screensaver proper?
>>>>>
>>>>>       
>>>> I'm sure that it is unix_chkpwd that is auditing and not
>>>> gnome-screensaver-dialog.
>>>>     
>>> Is gnome-screensaver-dialog not running the user domain?
>> I believe this is true.
>>
>>>   I would have
>>> expected that it was, and that when unix_chkpwd is run, that it
>>> transitions to *_unix_chkpwd_t, which should be able to send audit
>>> messages.
>>>
>>>   
>> You know policy better than I, where is the policy for this?
> 
> In authlogin_per_role_template():
> 
> 	role $3 types $1_chkpwd_t;
> 
> 	# Transition from the user domain to this domain.
> 	domtrans_pattern($2,chkpwd_exec_t,$1_chkpwd_t)
> 
Gnome-clock and other policies are to cover

policykit/hal/dbus interaction where the system debus is doing things on
behalf of the logged in user.  In this case the latest gnome clock
allows a user to specify the timezone that he is in, as well as change
the time.  So we want policy on the script that is execed by dbus for
the user.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhtODQACgkQrlYvE4MpobPgoQCgtXmqEsGaexePJMro55Vb6/Db
oRMAnjRW/GTMEIiBTyGPW/74vB4ZRnvT
=JNQd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
