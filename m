Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P1PEZG032187
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 21:25:14 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P1PDgJ013372
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:25:14 GMT
Message-ID: <48892B73.9000507@redhat.com>
Date: Thu, 24 Jul 2008 21:25:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: david@hardeman.nu, selinux@tycho.nsa.gov
Subject: Re: [refpolicy-patch 14/23] rhgb policy update
References: <20080719205002.462190042@hardeman.nu>	 <20080719210253.302868396@hardeman.nu>	 <1216758563.4954.35.camel@defiant.pebenito.net> <1216943043.4931.0.camel@defiant.pebenito.net>
In-Reply-To: <1216943043.4931.0.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris PeBenito wrote:
> On Tue, 2008-07-22 at 16:29 -0400, Chris PeBenito wrote:
>> On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
>>> plain text document attachment (policy_modules_services_rhgb.patch)
>>> rhgb (RedHat Graphical Boot) is RH specific so this should be uncontroversial...
>>>
>>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.if serefpolicy-3.5.0/policy/modules/services/rhgb.if
>>> --- nsaserefpolicy/policy/modules/services/rhgb.if	2008-07-10 11:38:46.000000000 -0400
>>> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.if	2008-07-15 14:05:13.000000000 -0400
>>> @@ -4,7 +4,7 @@
>>>  ## <summary>
>>>  ##	RHGB stub interface.  No access allowed.
>>>  ## </summary>
>>> -## <param name="domain" unused="true">
>>> +## <param name="domain">
>>>  ##	<summary>
>>>  ##	N/A
>>>  ##	</summary>
>> This reverses an upstream change.
>>
>>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.te serefpolicy-3.5.0/policy/modules/services/rhgb.te
>>> --- nsaserefpolicy/policy/modules/services/rhgb.te	2008-07-10 11:38:46.000000000 -0400
>>> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.te	2008-07-15 14:05:13.000000000 -0400
>>> @@ -92,6 +92,7 @@
>>>  term_getattr_pty_fs(rhgb_t)
>>>  
>>>  init_write_initctl(rhgb_t)
>>> +init_chat(rhgb_t)
>>>  
>>>  libs_use_ld_so(rhgb_t)
>>>  libs_use_shared_libs(rhgb_t)
>> This interface doesn't exist.
> 
> This is more towards Dan, but how much do we care about this policy, now
> that rhgb has been removed from Fedora?
> 
Probably not for Fedora, but it is still in RHEL5.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiJK3MACgkQrlYvE4MpobMsMACbB+ue533Sh87qH1rSiMdu3Id7
xswAn0WA8q9ROfxj1yWTOZEthMPQFztm
=jlwQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
