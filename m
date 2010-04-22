Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3MD4mEa013788
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 09:04:48 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3MD4FEt016183
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 13:04:15 GMT
Message-ID: <4BD0496C.80408@redhat.com>
Date: Thu, 22 Apr 2010 09:04:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>	 <4BCF05D3.5090700@redhat.com> <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
In-Reply-To: <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/21/2010 09:53 PM, Karl MacMillan wrote:
> On Wed, Apr 21, 2010 at 10:04 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> Ok that works, but If we move to a more general case. or openvn_t
>> getattr on etc_t
>>
>> #============= openvpn_t ==============
>> # src="openvpn_t" tgt="etc_t" class="file", perms="getattr"
>> # comm="openvpn" exe="" path=""
>> # Interface options:
>> #   automount_exec_config(openvpn_t) # [51]
>> #   files_exec_etc_files(openvpn_t) # [51]
>> #   files_delete_etc_files(openvpn_t) # [118]
>> #   files_relabel_etc_files(openvpn_t) # [136]
>> #   files_rw_etc_files(openvpn_t) # [161]
>> #   files_read_etc_files(openvpn_t) # [171]
>> #   files_manage_etc_files(openvpn_t) # [179]
>> #   auth_use_nsswitch(openvpn_t) # [1342]
>> #   seutil_semanage_policy(openvpn_t) # [3489]
>> #   auth_login_pgm_domain(openvpn_t) # [3717]
>> #   portage_compile_domain(openvpn_t) # [4004]
>>
>> I would have expected files_read_etc_files(openvpn_t)  to be the
>> closest/best match.
>>
> 
> Can you send me the audit messages for this?
> 
>> The tool is getting confused by attributes.  Since attributes are not
>> currently interpretable, they should be eliminated from the calculation.
>> Best way to do this is just eliminate any types that don't end in a _t.
> 
> I'm not certain what you mean by this - confused in what way? The only
> thing I know about is the lack of typattribute statements. The
> attached patch adds attribute handling to sepolgen. It's only lightly
> tested but I wanted you to get it sooner rather than later.
> 
> Karl
> 
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v2.0.14 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAkvPBdMACgkQrlYvE4MpobP9IQCePlmwSbiO94NTCiu1mHwUzdkI
>> 8YsAn3tlgDQljeLLLhJmMaUGRHFkrBVp
>> =8OfI
>> -----END PGP SIGNATURE-----
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
First let me get rid of these ^M all over the patch.pwd

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvQSWwACgkQrlYvE4MpobPjqQCgkQAXldyncbGkD5KgOI49vVRQ
b0sAoJ2wSfzsPELFd9efh4XRtKdBACR1
=Pkv1
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
