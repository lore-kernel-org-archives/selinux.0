Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9ALR9CH031803
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 17:27:09 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9ALPtR3012645
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 21:25:55 GMT
Message-ID: <48EFC8A7.3040104@redhat.com>
Date: Fri, 10 Oct 2008 17:27:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Joe Nall <joe@nall.com>, Joshua Brindle <method@manicmethod.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: per role template confusion
References: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>	 <48EE688E.8040507@manicmethod.com>	 <668EB1B5-63B3-4491-8904-619127F6DE67@nall.com> <1223643494.2165.148.camel@gorn>
In-Reply-To: <1223643494.2165.148.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Thu, 2008-10-09 at 18:17 -0500, Joe Nall wrote:
>> On Oct 9, 2008, at 3:24 PM, Joshua Brindle wrote:
>>
>>> Joe Nall wrote:
>>>> Can someone explain the per role template implementation? I am  
>>>> confused.
>>>>
>>>> During policy compilation, a .mod.role file is created that just  
>>>> references the roles in /usr/share/selinux/devel/include/rolemap  
>>>> regardless of the roles defined via semanage. Should semanage add  
>>>> roles to rolemap? Is there additional magic in semodule?
>>>>
>>>> joe
>>> Roles aren't created by semanage, only user->role mappings. The  
>>> per_role_template creates derived types for each role (eg.,  
>>> staff_mozilla_t, sysadm_mozilla_t). These roles are defined in the  
>>> policy only.
>> Ok. I thought the role statement just did type mapping and did not  
>> realize there was an implicit role declaration.
>>
>> I would still like an explanation of how this works and if/how new  
>> roles are handled with respect to per role templates.
> 
> For each entry in the rolemap file, the infrastructure calls the
> [modulename]_per_role_template() for each module, if it exists.
> 
This does NOT happen in Fedora.  I have patched this out and force
explicit calls to per_role_templates.  Calling them globably forces all
confined users to transition to per_role_templates even when you don't
want them to.

I believe this is a mistake.
> If (u|r)bacsep succeeds, this will be dropped in favor of explicit
> calls.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjvyKcACgkQrlYvE4MpobPzdgCffiTnFd8dU3PbVdYCklN0MCWK
QrcAoOdfb/vgix0G2smLpgSkb0InJEiI
=np8I
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
