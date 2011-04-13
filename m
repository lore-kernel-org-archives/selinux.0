Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3DAPKEa019852
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 06:25:41 -0400
Received: from e24smtp05.br.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3DAPJPc018356
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 10:25:19 GMT
Received: from /spool/local
	by e24smtp05.br.ibm.com with XMail ESMTP
	for <selinux@tycho.nsa.gov> from <rcvalle@linux.vnet.ibm.com>;
	Wed, 13 Apr 2011 07:25:18 -0300
Message-ID: <4DA579E8.6040404@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2011 07:24:40 -0300
From: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux mixed/virtualisation policy
References: <4DA1E50F.4060506@linux.vnet.ibm.com> <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com> <1302539583.7338.43.camel@moss-pluto>  <4DA3417A.2030009@redhat.com> <1302612646.25774.11.camel@moss-pluto>
In-Reply-To: <1302612646.25774.11.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/2011 09:50 AM, Stephen Smalley wrote:
> On Mon, 2011-04-11 at 13:59 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 04/11/2011 12:33 PM, Stephen Smalley wrote:
>>> On Mon, 2011-04-11 at 11:24 -0400, Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> On 04/11/2011 09:40 AM, Stephen Smalley wrote:
>>>>> On Sun, 2011-04-10 at 14:12 -0300, Ramon de Carvalho Valle wrote:
>>>>>> However, I and Dan Walsh (who kindly informed me about libvirt) both
>>>>>> agree that dynamic labeling is more secure than manual labeling using
>>>>>> MLS policy, for virtual machine environments.
>>>>>
>>>>> Can you elaborate on what your concern is there?  If it is merely that
>>>>> two VMs at the same level are not isolated via the MLS policy, then that
>>>>> isn't a MLS concern, and you could use TE instead to isolate the VMs of
>>>>> the same level.
>>>>>
>>>> I think what he is after is the convenience of dynamic labeling, for
>>>> isolation.  Yes he could create new types for each instance, which every
>>>> virtual machine would need, this could cause a potential explosion in
>>>> the number of types and would be subject to failure.  It would be
>>>> putting a large onus on the Admin to manage all of these types.  The
>>>> real beauty of dynamic labeling is that it just works.
>>>
>>> The types could be automatically generated from a template, and managed
>>> by libvirt in much the same way it presently manages categories.
>>>
>>> In any event, he can do the same thing by use of categories rather than
>>> introducing an incomparable set of sensitivities, and that wouldn't
>>> require any changes to the policy toolchain or kernel security server.
>>>
>>
>> Well yes, but currently svirt can support out of the box ~500,000 svirt
>> instances,  If we when with  a type system, this would probably some
>> problems adding a couple of million types.  I don't think we want svirt
>> recompiling and loading policy every time it launches a virtual machine.
>>  :^)
>>
>> Reserving a pool of categories at might be the way to go.  But at what
>> security level?  s15 or s0?  Also what about shared data between the
>> virtual machines, read only content.  Currently that is just labeled s0.
> 
> I think this is where Ramon's idea breaks down.  The qemu process does
> in fact need access to resources and other services on the host and thus
> making the qemu process run in a context that is completely incomparable
> with the contexts used by host processes and objects will quickly put
> you into a situation where you must grant the qemu process MLS
> overrides.  At which point you are no longer deriving much benefit from
> the MLS policy at all.
> 
Not exactly. Could you give us an example of such a situation?

The processes representing virtual machine environments and its
associated resources should belong to the virtualisation sensitivities,
as well as the libvirt daemon. PCI passthrough should be a case a part,
as it needs to be detached from the host anyway--It should be explicitly
allowed and/or have a virtualisation sensitivity, which is the recommended.

Currently, the libvirt daemon executes with s0-s15:c0.c1023, which is
far more concerning than sv0-sv15:c0.c1023. So where is MLS?

So far we have been discussing how to accomplish what was proposed using
costly non standard methods and workarounds without considering the
benefits of a far more elegant solution, which until now does not seem
to have any downsides--despite the development effort.

We must consider that virtualisation is not something that is invented
every decade, and how much more we have the operating system and its
security mechanisms aware of it, is to be prepared for what comes next.


- -- 
Ramon de Carvalho Valle
Security Engineer
IBM Linux Technology Center
rcvalle@linux.vnet.ibm.com
http://rcvalle.com/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2leegACgkQkcIYeh81wLmNCgCfVsawKWHPyRVggTJVuN0OKz1v
x8oAn3rnlfGRNgdJO1ecMfqP0cGy/C4Y
=bxbs
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
