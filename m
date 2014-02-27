Message-ID: <530FA62C.4080308@redhat.com>
Date: Thu, 27 Feb 2014 15:55:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] selinux: put the mmap() DAC controls before the MAC
 controls
References: <20140227143045.14242.66994.stgit@localhost>
 <2802481.ZiEtmME2xN@sifl> <530F673B.5080906@tycho.nsa.gov>
 <3974420.4TmIcvnhqi@sifl> <530F9359.9020505@redhat.com>
 <530F976E.8050108@tycho.nsa.gov> <530F9B1B.3020204@tycho.nsa.gov>
In-Reply-To: <530F9B1B.3020204@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: casey.schaufler@intel.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/27/2014 03:07 PM, Stephen Smalley wrote:
> On 02/27/2014 02:52 PM, Stephen Smalley wrote:
>> On 02/27/2014 02:34 PM, Daniel J Walsh wrote:
>>> On 02/27/2014 02:25 PM, Paul Moore wrote:
>>>> On Thursday, February 27, 2014 11:26:35 AM Stephen Smalley wrote:
>>>>> On 02/27/2014 11:22 AM, Paul Moore wrote:
>>>>>> On Thursday, February 27, 2014 10:57:46 AM Stephen Smalley
>>>>>> wrote:
>>>>>>> On 02/27/2014 09:30 AM, Paul Moore wrote:
>>>>>>>> It turns out that doing the SELinux MAC checks for mmap()
>>>>>>>> before the DAC checks was causing users and the SELinux
>>>>>>>> policy folks headaches as users were seeing a lot of SELinux
>>>>>>>> AVC denials for the memprotect:mmap_zero permission that
>>>>>>>> would have also been denied by the normal DAC capability
>>>>>>>> checks (CAP_SYS_RAWIO).
>>>>>>> 
>>>>>>> So you think that the explanation given in the comment for the 
>>>>>>> current ordering is no longer valid?
>>>>>> 
>>>>>> Yes and no.  Arguably there is still some value in it but there
>>>>>> are enough problems with it as-is that I think the value is
>>>>>> starting to be outweighed by the pain it is causing (Dan can be
>>>>>> very annoying when he wants something <g>). For those users who
>>>>>> still want notification of processes trying to mmap() low
>>>>>> addresses, I think an audit watch is a much better approach.  I
>>>>>> don't think SELinux shouldn't be acting as an intrustion
>>>>>> detection tool when we have other things that do that job.
>>>>>> 
>>>>>> Let's also not forget that the MAC-before-DAC approach goes
>>>>>> against the general approach to applying SELinux controls, so
>>>>>> there is some argument to be had for consistency as well.
>>>>>> 
>>>>>> Do you have a strong objection to this patch?
>>>>> 
>>>>> No, although I do wonder if we ought to just dispense with
>>>>> mmap_zero altogether at this point.  It made sense when there was
>>>>> no capability check or if the capability was one of the extremely
>>>>> broad ones (e.g. CAP_SYS_ADMIN), but I don't really see why we
>>>>> can't be just as restrictive with CAP_SYS_RAWIO / sys_rawio as with
>>>>> mmap_zero.
>>> 
>>>> Seems like a reasonable argument to me.  I pinged Eric to get his
>>>> thoughts on the issue since he added the check originally; if he is
>>>> okay with removing it, I'll go ahead do it.
>>> 
>>> The only thing is this is a nice debugging tool for the kernel.
>>> Finding apps that accidentally mmap_zero.
>> 
>> You'll still see sys_rawio avc denials and the audit syscall record will 
>> show that it was mmap of a low address.
> 
> Looking at Fedora policy, there are differences in what domains are allowed
> mmap_zero vs sys_rawio, although I don't know how intentional/meaningful
> that is.
> 
> sesearch -A -p mmap_zero vs sesearch -A -p sys_rawio
> 
> Why for example does cupsd_t have sys_rawio?  That's rather disturbing.
> 
> I guess you should keep the separate check until those differences are 
> resolved.
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
> 

Don't know why cups has it but I will remove it.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMPpiwACgkQrlYvE4MpobOnrACfUE/quImyDenbAQ0b3xytW5FU
2tEAniONTu0sIUbuqxObgofqZb/J+JQx
=oLp9
-----END PGP SIGNATURE-----
