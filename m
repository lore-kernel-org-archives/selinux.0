Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r57AcLNj016529
	for <selinux@tycho.nsa.gov>; Fri, 7 Jun 2013 06:38:21 -0400
Message-ID: <51B1B811.9020905@itechfrontiers.com>
Date: Fri, 07 Jun 2013 06:38:09 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: mthode@mthode.org
CC: selinux@tycho.nsa.gov
Subject: Re: selinux on zfs(onlinux)
References: <51B125CE.5020801@mthode.org> <51B12FD4.5070206@itechfrontiers.com> <51B14452.8040701@mthode.org>
In-Reply-To: <51B14452.8040701@mthode.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 6/6/2013 10:24 PM, Matthew Thode wrote:
> On 06/06/2013 07:56 PM, Patrick K., ITF wrote:
>> Hello,
>>
>> Excuse me,  But ZFS is a patented technology Owned by Oracle Inc., and
>> only its implementation in CDDL was/is free.
>>
>> CDDL is incompatible with GPL,
>>
>> How come that ZFS can be used as root File System on Linux then?! , ZFS
>> cannot be integrated into kernel due to Legal reasons as explained,
>> unless every recipient makes modification and compilation himself/herself.
>>
>> Even if you make a Module you cannot distribute it as binary, subject to
>> derivative work.
>>
>> If you distribute it as Module you must distribute source code, and the
>> recipient must compile the whole kernel (on every system that is being
>> deployed).
>>
>> If you compile into binary module and distribute it, then due to linking
>> you still violate CDDL (derivative work)
>>
>> All may result in getting sued by Oracle Inc. due to Patent violation.
>>
>>
>> Best regards,
>>
>>     Patrick K.
>>
>> On 6/6/2013 8:14 PM, Matthew Thode wrote:
>>> zfs is very close to usable as a root file-system with selinux, but is
>>> just missing one thing, it doesn't know what to set the root context to
>>> on mount.
>>>
>>> I am going to petition for this to be added as a property, but should it
>>> be called rootcontext (want to make sure it's valid).
>>>
>>> system_u:object_r:fs_t is what I used just to get my system working
>>> (including stuff like /usr, but meh).
>>>
>>>
>>> here is the upstream bug if curious
>>> https://github.com/zfsonlinux/zfs/issues/1504
>>>
>>>
>
> zfs version 28 was released under the cddl, which means it is not able
> to be integrated statically into the kernel and then redistributed (my
> interpretation).  I can create my own static kernel image with zfs and
> use it on my own though (and this is my preferred method of using it).
>

I believe you need to consult with a lawyer, that's not entirely right, 
I'm very well aware of that.(FreeBSD and Illumos - former OpenSolaris- 
The question was rhetorical making you pay attention to the legal facts)


> You are also able to use proprietary kernel modules as well.  Ever use
> the AFS (filesystem) on Linux?  Here is a link as to what Linus has to
> think on the mater.
> http://linuxmafia.com/faq/Kernel/proprietary-kernel-modules.html
>

OpenAFS has different License it is IPL. Do you pay attention to the 
licenses? You need to ask your lawyer.

And it seems you do not read what Linus wrote, he admits about modules 
" ... (they can potentially be considered derived works, even if you 
don't actually link them into the kernel, per se) ..."


He somewhat wants to ignore that, as long as the IPR owner has no issue 
Linus won't cause trouble, but Oracle Inc. has issues on this, They are 
selling ZFS Storage and ZFS is a core feature of Solaris, They have very 
clear commercial interest in it, in fact originally CDDL was chosen (at 
SUN) to some extent due to keeping their rights.




> The CDDL provides a patent grant and the conflict only affects
> distribution of linked binaries on the GPL end.  Since the modules are
> from Solaris, they are not considered a derived work, so the derived
> work in the GPL is irrelevant.  It is my interpretation that I can make
> and distribute a module, but that is not the question here.
>


This is different, The owner of the IPR (Intellectual Property Right) 
Originally SUN Micros systems Inc and Now Oracle Inc, has not created 
that Module, and has not granted such right,  only CDDL version is free 
and comes with granted right  not infringing the patents.


When third parties create module for Kernel they combine it with enough 
code and adapt it with Linux Kernel that constitutes a derivative work, 
which is in case of kernel it should be in GPL,  GPL requires you to 
make all the code GPL,  you cannot change the License of the CDDL parts 
(according to CDDL grant of rights), if you do that you have terminated 
your agreement and you lose granted rights to patents.

When you create the Module in the case of File system you make 
derivative work of Linux then the entire work needs to be in GPL (While 
CDDL license does not permit you to change the license of those parts 
that are already in CDDL)


In an enterprise if you deploy such Module, and use outsourced 
technicians or companies then they are distributing illegal and 
unlicensed code, since the fair usage case is when the owner of the 
system applies modification to his/her/its system, if third parties do 
so it is a clear case of distribution.

Thus no sane and law abiding management would let you use that.


Please see this page:

https://blogs.oracle.com/chandan/entry/copyrights_licenses_and_cddl_illustrated

> So, do you think the name for that zfs property would be accurate
> (rootcontext)?


The correct legal method of using ZFS under Linux is using it through 
(iSCSI, Fiber Channel, ATAoE) SAN or NAS on FreeBSD, Illumos, Solaris or 
Oracle's ZFS Storage systems.

Notice: Legal issues explained in this message are for information 
purposes only and should not be considered as legal advice, please 
consult with your lawyer for legal advice.

Best Regards,

Patrick K.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
