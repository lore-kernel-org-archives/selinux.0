Message-ID: <487DE0CA.4020904@redhat.com>
Date: Wed, 16 Jul 2008 07:51:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: rawhide policy on FC9 build fails
References: <cadfc0e40807151044t62062e1ap7950c5a0f2c1e5a4@mail.gmail.com> <1216204737.17602.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1216204737.17602.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2008-07-15 at 12:44 -0500, Xavier Toth wrote:
>> I wanted to experiment with running the latest policy (I want the
>> latest X policy) on FC9 so I got the source rpm and tried to build it.
>> I update to the required checkpolicy version and also update libsepol
>> since rawhide and FC9 use the same version. The rpmbuild however fails
>>
>> m4 -D enable_mls -D distro_redhat -D mls_num_sens=16 -D
>> mls_num_cats=1024 -D mcs_num_cats=1024 -D hide_broken_symptoms -D
>> self_contained_policy policy/support/file_patterns.spt
>> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
>> policy/support/misc_macros.spt policy/support/misc_patterns.spt
>> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
>> tmp/generated_definitions.conf policy/global_booleans
>> policy/global_tunables > tmp/global_bools.conf
>> Creating mls base module base.conf
>> cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
>> tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
>> base.conf
>> Compiling mls base module
>> /usr/bin/checkmodule -M -U deny base.conf -o tmp/base.mod
>> /usr/bin/checkmodule:  loading policy configuration from base.conf
>> libsepol.expand_module: Error while indexing out symbols
>> /usr/bin/checkmodule:  expand module failed
>> make: *** [tmp/base.mod] Error 1
>> error: Bad exit status from /var/tmp/rpm-tmp.2964 (%install)
>>
>>
>> RPM build errors:
>>     Bad exit status from /var/tmp/rpm-tmp.2964 (%install)
>>
>> I know this is a bit out of the mainstream but I'd appreciate any help.
> 
> This is the same problem noted by Russell Coker in the checkmodule
> thread.  The latest refpolicy requires the user and role remapping
> support in order to move roles into modules, and that was added in
> libsepol 2.0.29 and checkpolicy 2.0.16 after Fedora 9 GA.  So the Fedora
> 9 checkpolicy is too old to build latest refpolicy.  I think Dan was
> planning on pushing an update to F9 with the latest userland.
> 
libsepol has been released to Fedora Updates and checkpolicy should be
going into fedora-testing.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh94MkACgkQrlYvE4MpobOSmgCgpIfe4MpmxTGwWGXhtU4jwVLq
A88AnAx9FLdBKkp0zLTNN4OyNK2YRoMl
=Blih
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
