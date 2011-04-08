Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p38Ied0h020484
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2011 14:40:41 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p38IedwH019379
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2011 18:40:40 GMT
Message-ID: <4D9F56A0.7040804@redhat.com>
Date: Fri, 08 Apr 2011 14:40:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
CC: rhel6-cc-external-list@redhat.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [Rhel6-cc-external-list] Processes executing as qemu_t SELinux
 type are not allowed to access vhost_device_t
References: <4D920264.5040702@linux.vnet.ibm.com> <4D9205B7.8030509@linux.vnet.ibm.com> <4D920CC4.8000501@redhat.com>	<4D9210FA.3060206@linux.vnet.ibm.com> <4D92234C.6040402@redhat.com>	<4D93243C.5090607@linux.vnet.ibm.com> <4D9376B4.2080805@redhat.com>	<4D9377A7.5080001@linux.vnet.ibm.com> <4D937A88.9080109@redhat.com>	<4D948B46.6030902@linux.vnet.ibm.com> <4D948C92.4090106@redhat.com>	<4D948E6D.1000205@linux.vnet.ibm.com> <4D94A8D3.2020106@redhat.com>	<4D94AA3C.5070906@linux.vnet.ibm.com> <4D94AB7D.5060207@redhat.com>	<4D94E02B.10907@linux.vnet.ibm.com> <4D95E990.5040903@redhat.com> <4D960EC2.8090506@linux.vnet.ibm.com> <4D96226F.603@linux.vnet.ibm.com> <4D96260F.5020702@redhat.com> <4D962B0B.4020207@linux.vnet.ibm.com> <4D9A00D6.2090408@redhat.com> <4D9A22DC.6070309@linux.vnet.ibm.com> <4D9A25A7.1000803@redhat.com> <4D9CA8AD.9030702@linux.vnet.ibm.com> <4D9CADBE.2080001@redhat.com> <4D9CC5C5.1040508@linux.vnet.ibm.com> <4D9F4C2D.9090207@linux.vnet.ibm.com>
In-Reply-To: <4D9F4C2D.9090207@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/08/2011 01:55 PM, Ramon de Carvalho Valle wrote:
> Hi Daniel,
> 
> On 04/06/2011 04:57 PM, Ramon de Carvalho Valle wrote:
>>> I don't see how this would be ok.  The sad part is I would argue dynamic
>>>> labeling is more secure the static labeling.
>> The result is that most of the tests for the evaluation does not apply
>> to the MLS policy (I will send them in a separate email).
> 
>>>>
>>>> If you label to virt machines as TopSecret, a compromized TopSecret
>>>> Machine could attack all the virtual Machines that are running as
>>>> TopSecret.  In Dynamic labeling all virtual machines are isolated.
>>>>
>>>> I guess you could carve up a subsection of the MLS/MCS namespace and
>>>> allow libvirt to set labels in those zones.  But the idea of an app
>>>> randomly changing the label of a file/device on the fly, is not what MLS
>>>> tends to like.
>> This may be something that is not desirable. However, the default MLS
>> dominance could be changed to have one sensitivity excluded from the
>> dominance hierarchy (or a new sensitivity be added). Thus, for that
>> removed (or new) sensitivity, libvirt could execute with dynamic
>> labeling enabled.
> What you think of the implementation of a sensitivity s16 (or sv) out of
> the s0-s15 hierarchy? The argument would be that a virtual machine must
> be considered as a single isolated physical device, and is not part of
> the MLS logical hierarchy of objects in the host.
> 
> Best regards,
> 


We could do that, but it is not MLS, at that point.  It would involve
some engineering of libvirt and some policy rewrite to allow MLS values
of > s15.  I am not sure what the definition of SystemHigh would be
then.  I think it would be best if this was brought up for discussion on
a public list like SELinux <selinux@tycho.nsa.gov>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAk2fVqAACgkQrlYvE4MpobM4SgCgmjBMJ7AcQjuaOR9T36ZO2KZ/
u/sAliDiRRN0i34hSutOywuBpAa2cLg=
=IJ63
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
