Message-ID: <4CF56E3D.7050101@redhat.com>
Date: Tue, 30 Nov 2010 16:35:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: analysing optional policy
References: <201011262055.01924.russell@coker.com.au> <1291142657.1328.71.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1291142657.1328.71.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/30/2010 01:44 PM, James Carter wrote:
> On Fri, 2010-11-26 at 20:55 +1100, Russell Coker wrote:
>> I'm having a problem with optional policy not being used when I think it 
>> should.
>>
>> Is it possible to use apol to get information on optional policy for .pp files 
>> so I can try to work out why it doesn't get enabled?
>>
>>                 unconfined_run_to(depmod_t, depmod_exec_t)
>>
>> In the Debian policy I have the above in an optional section of base.pp but 
>> for reasons that I don't understand it's not being loaded (both tests and 
>> running apol on policy.24 show this).
>>
>> I've inspected the contents of base.conf and they appear to be OK.
>>
>> Any suggestions of other tools to analyse this will be appreciated.
>>
> 
> I have a policy compiler written in Lua that I used in the past to
> experiment with language extensions and that I am currently working
> towards being able to convert Refpolicy to CIL.  It is not industrial
> strength and not friendly to anyone except its creator, but it does
> display more error messages.
> 
> Running it on the policy in selinux-policy-src_0.2.20100524-4_all.deb I
> found the following:
> 
> Same paramater used as a role and a type:
> - Line 69 in ../debian_policy/policy/modules/apps/seunshare.if
> 
> Undefined macro calls:
> - samba_run_smb at Line 180 in ../debian_policy/policy/modules/apps/qemu.if
> - macro userdom_unpriv_usertype at Line 103 in ../debian_policy/policy/modules/apps/wine.if
> - file_type_auto_trans at Line 308 in ../debian_policy/policy/modules/system/ipsec.te
> 
> Types used as an alias:
> - procmail_t at Line 10 in ../debian_policy/policy/modules/services/lda.te
> - procmail_exec_t at Line 12 in ../debian_policy/policy/modules/services/lda.te
> - procmail_tmp_t at Line 17 in ../debian_policy/policy/modules/services/lda.te
> 
> Types not declared:
> - httpd_nagios_script_exec_t
> - httpd_cobbler_script_exec_t
> - httpd_smokeping_cgi_script_exec_t
> - httpd_nutups_cgi_script_exec_t
> - lsassd_t
> - dkim_var_run_t
> - dkim_t
> 
> I believe that some of these errors are also in Refpolicy.
> 
> I don't see anything related to your problem here.
> 
> I've attached the current version of my compiler.
> Unfortunately, it treats Refpolicy pre m4 expansion as the policy
> language, so I need to patch a few things in the policy to make it work.
> 
> So apply the attached patch and then run something like the following:
> ./fpp.lua -p ../debian_policy/ > policy.conf
> 

One thing I got burned on last night was a gen_require block with a
spelling mistake.  So it pulled a hole section of policy out.

It would be cool, it we could check that all types that are required
within an interface file are defined within the te file.

foobar.if should not require types that are not defined in foobar.te.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz1bj0ACgkQrlYvE4MpobNVAACgzGbRdjVNBgDu6nDZaNvWjJJQ
G1YAoMCnf+hV2RtkSRUNXS4HPr5KkmuL
=rJpA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
