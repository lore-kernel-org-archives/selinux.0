Message-ID: <4DA36C96.4040800@redhat.com>
Date: Mon, 11 Apr 2011 17:03:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: chanson@TrustedCS.com
CC: sds@tycho.nsa.gov, rcvalle@linux.vnet.ibm.com, SELinux@tycho.nsa.gov
Subject: Re: SELinux mixed/virtualisation policy
References: <4DA1E50F.4060506@linux.vnet.ibm.com>	 <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com> <1302539583.7338.43.camel@moss-pluto> <4DA3417A.2030009@redhat.com> <170D6ABBBA770349AA49582A86FCED1503F9EF3A@HAVOC.tcs-sec.com>
In-Reply-To: <170D6ABBBA770349AA49582A86FCED1503F9EF3A@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/11/2011 04:44 PM, chanson@TrustedCS.com wrote:
>  
> 
>>> The types could be automatically generated from a template, and 
>>> managed by libvirt in much the same way it presently 
>> manages categories.
>>>
>>> In any event, he can do the same thing by use of categories rather 
>>> than introducing an incomparable set of sensitivities, and that 
>>> wouldn't require any changes to the policy toolchain or 
>> kernel security server.
>>>
>>
>> Well yes, but currently svirt can support out of the box 
>> ~500,000 svirt instances,  If we when with  a type system, 
>> this would probably some problems adding a couple of million 
>> types.  I don't think we want svirt recompiling and loading 
>> policy every time it launches a virtual machine.
>>  :^)
>>
>> Reserving a pool of categories at might be the way to go.  
>> But at what security level?  s15 or s0?  Also what about 
>> shared data between the virtual machines, read only content.  
>> Currently that is just labeled s0.
>>
> 
> I would suggest some level in between s0 and s15. I would agree with
> Stephen that dynamic types would be preferred. I guess it just depends
> on the reason you are using the MLS policy.
> 
> -Chad
> 
>  
Because you have virtual machines with data at different levels.

Of course you could have a multi-level virtual machine running with
multiple single level machines on the same multi-level virtual host.

Makes your head ache.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2jbJYACgkQrlYvE4MpobPZxACeMoZUpo678s8oPnkcG6BPvtUw
pKIAn37UKb80ghIqFzNyBr+4cxHxvZLD
=cSoU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
