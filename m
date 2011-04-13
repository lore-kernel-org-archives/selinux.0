Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3DIXw7r015258
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 14:33:58 -0400
Received: from e24smtp03.br.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3DIXuv8028008
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 18:33:57 GMT
Received: from /spool/local
	by e24smtp03.br.ibm.com with XMail ESMTP
	for <selinux@tycho.nsa.gov> from <rcvalle@linux.vnet.ibm.com>;
	Wed, 13 Apr 2011 15:33:55 -0300
Message-ID: <4DA5EC8C.5030207@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2011 15:33:48 -0300
From: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: SELinux mixed/virtualisation policy
References: <4DA1E50F.4060506@linux.vnet.ibm.com> <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com> <1302539583.7338.43.camel@moss-pluto>  <4DA3417A.2030009@redhat.com> <1302612646.25774.11.camel@moss-pluto>	 <4DA579E8.6040404@linux.vnet.ibm.com> <1302697169.16451.12.camel@moss-pluto>	 <4DA59F38.7090101@linux.vnet.ibm.com> <1302702685.16451.25.camel@moss-pluto> <4DA5ACBF.7020704@redhat.com>
In-Reply-To: <4DA5ACBF.7020704@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/13/2011 11:01 AM, Daniel J Walsh wrote:
> On 04/13/2011 09:51 AM, Stephen Smalley wrote:
>> On Wed, 2011-04-13 at 10:03 -0300, Ramon de Carvalho Valle wrote:
>>> On 04/13/2011 09:19 AM, Stephen Smalley wrote:
>>>> At present, virtd_t (i.e. libvirtd) is given many (all?) MLS overrides,
>>>> which is unsurprising since it is expected to create and manage VMs at
>>>> any level.  But qemu_t (i.e. the qemu process representing the
>>>> individual VM) is not given such MLS overrides, nor should it, as that
>>>> would allow to escape the confines of its level/range.
>>> Actually, processes representing virtual machine environments--when
>>> initiated by libvirt--execute with svirt_t and not qemu_t, which also
>>> belongs to virt_domain type attribute. So why the virt_domain rules
>>> could not be moved to the virtualisation sensitivities?
> 
>> The same is true for svirt_t - if you look at the policy, you'll see
>> that it interacts with various host processes and accesses various host
>> files.  You can't push all of those into your new sensitivities, and
>> thus the end result will be that you'll have to allow interactions
>> between the "regular" sensitivities and the "virtualization"
>> sensitivities, thereby adding more exceptions to the MLS constraints.
> 
>>>> I can't quite see how your approach is cleaner than just using separate
>>>> categories.  Same effect - by allocating a dedicated category to the VMs
>>>> and another to the host, you end up with incomparable levels and thus
>>>> will achieve automatic isolation except where explicitly overridden
>>>> using the type attributes for MLS overrides.  Adding another
>>>> incomparable set of sensitivities puts us outside the scope of any
>>>> evaluated or even published security model.
>>> How dynamic labeling is supposed to work with this approach? We will
>>> need a standard set of categories defined to libvirt use.
> 
>> Yes, you just need to standardize some allocation for libvirt, which
>> realistically ought to be done anyway, since we already have other users
>> of categories like sandbox.
> 
>>>> Now something that has been suggested in the past would be adding
>>>> another level/range component to the security context for use by a
>>>> Biba-like integrity model.  That might be interesting, but would
>>>> obviously require quite a few changes on both the kernel and userland
>>>> side.  It would also require resolving the unfortunate ambiguity in the
>>>> current security context format.
>>> Please, correct if I am wrong, but from what I understand adding another
>>> level and range component will just add another level of hierarchy for
>>> multiple set of sensitivities and categories (i.e.
>>> s0-s15:s0-s15:c0.c1023 or even s0-s15:c0.c1023:s0-s15:c0.c1023). So the
>>> virtualised sensitivities should be below or above the standard
>>> sensitivities in this new level and range component?
> 
>> Having another level/range component (or more generally, an extensible
>> list of level/range components) would more easily delineate multiple
>> uses of the level/range for different purposes.  So you could have
>> simultaneous MLS+libvirt dynamic labeling without needing to worry about
>> allocation of categories between them.  Or you could have simultaneous
>> MLS+Biba.  Or all three (if extensible).
> 
> 
> I will open a bugzilla with libvirt to allow the admin to specify a
> sensitivity and a range of MCS labels to randomly choose between.  This
> might be necessary for an other use case that suddenly seems to be
> picking up steam, labeled NFS.  If Labeled NFS happens we need a way to
> make sure two libvirt instances do not choose the same Categories, to
> start virtual machines.
Thank you very much Daniel. Please, add me to the Bugzilla.

> 
> 
> Sandbox MCS and SVirt MCS and any other MCS (Coming soon) should still
> be isolated by type enforcement rules.

- -- 
Ramon de Carvalho Valle
Security Engineer
IBM Linux Technology Center
rcvalle@linux.vnet.ibm.com
http://rcvalle.com/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2l7IwACgkQkcIYeh81wLlxGQCfQAsutMPdC30n4vohwYWXecrV
EFQAoI/FBn2C77vkkkRkePZNN/jntStF
=MbKr
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
