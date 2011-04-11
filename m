Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3BHFtdc025726
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 13:15:55 -0400
Received: from e24smtp01.br.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3BHFsob016781
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 17:15:54 GMT
Received: from /spool/local
	by e24smtp01.br.ibm.com with XMail ESMTP
	for <selinux@tycho.nsa.gov> from <rcvalle@linux.vnet.ibm.com>;
	Mon, 11 Apr 2011 14:15:53 -0300
Message-ID: <4DA33712.4050304@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2011 14:14:58 -0300
From: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux mixed/virtualisation policy
References: <4DA1E50F.4060506@linux.vnet.ibm.com> <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com> <1302539583.7338.43.camel@moss-pluto>
In-Reply-To: <1302539583.7338.43.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/11/2011 01:33 PM, Stephen Smalley wrote:
> On Mon, 2011-04-11 at 11:24 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 04/11/2011 09:40 AM, Stephen Smalley wrote:
>>> On Sun, 2011-04-10 at 14:12 -0300, Ramon de Carvalho Valle wrote:
>>>> However, I and Dan Walsh (who kindly informed me about libvirt) both
>>>> agree that dynamic labeling is more secure than manual labeling using
>>>> MLS policy, for virtual machine environments.
>>>
>>> Can you elaborate on what your concern is there?  If it is merely that
>>> two VMs at the same level are not isolated via the MLS policy, then that
>>> isn't a MLS concern, and you could use TE instead to isolate the VMs of
>>> the same level.
>>>
>> I think what he is after is the convenience of dynamic labeling, for
>> isolation.  Yes he could create new types for each instance, which every
>> virtual machine would need, this could cause a potential explosion in
>> the number of types and would be subject to failure.  It would be
>> putting a large onus on the Admin to manage all of these types.  The
>> real beauty of dynamic labeling is that it just works.
Yes, exactly.

> 
> The types could be automatically generated from a template, and managed
> by libvirt in much the same way it presently manages categories.
> 
> In any event, he can do the same thing by use of categories rather than
> introducing an incomparable set of sensitivities, and that wouldn't
> require any changes to the policy toolchain or kernel security server.
> 
I know it may be too intrusive to the policy toolchain. However,  there
are a number of benefits that may be taken in consideration.

This allows the categorization of processes representing virtual machine
environments in different sensitivities within a pre-defined standard
set which belongs only this type of processes-Instead of manually
reserving a non standard range of categories. Also, this may allow
virtualisation software to act in a well defined environment instead of
each one adopting custom different solutions (i.e. non standard range of
categories, dynamic labeling, different types for each instance).

Also, as Daniel said, this may allow the use of dynamic labeling within
one of these sensitivities (i.e. sv0), and allow custom processes
representing virtual machine environments to have static labels in the
same or other sensitivities with higher privileges. No other types of
processes should have access to these sensitivities unless explicitly
stated, which may be the case of libvirt.

This can be an entirely optional feature aimed to virtualised
environments and opens the possibility for developing new features that
could benefit from this additional level of granularity.

- -- 
Ramon de Carvalho Valle
Security Engineer
IBM Linux Technology Center
rcvalle@linux.vnet.ibm.com
http://rcvalle.com/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2jNxIACgkQkcIYeh81wLk/cACfefbk0X60e5e4NOWC3yQrygV8
/28An3xokMo4uCQ6lxZqlV1NhzuP2+NB
=qsVc
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
