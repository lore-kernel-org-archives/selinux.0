Message-ID: <555DD194.3060702@tycho.nsa.gov>
Date: Thu, 21 May 2015 08:37:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <brindle@quarksecurity.com>,
 William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
In-Reply-To: <555D3E20.7050907@quarksecurity.com>
Content-Type: text/plain; charset=utf-8
Cc: james.l.morris@oracle.com, linux-security-module@vger.kernel.org,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2015 10:08 PM, Joshua Brindle wrote:
> William Roberts wrote:
> <snip>
>>>> ---- Policy format ----
>>>> allow<source>  <target>:<class>  { 0x8910-0x8926 0x892A-0x8935 }
>>>> auditallow<source>  <target>:<class>  0x892A
>>> I agree with only specifying the lower 16 bits (command,type) when
>>> specifying
>>> the individual ioctls, I even like the '-' shortcut, but I'm a little
>>> concerned about specifying a number directly in the permission field
>>> without
>>> any sort of qualifier.  Specifically I'm worried that it hurts the
>>> readability
>>> of the policy and could pose problems with future work.
>>>
>>> I'd be much happier if we could add some sort of syntax which would
>>> qualify
>>> the numbers as ioctls, for example:
>>>
>>>    allow<source>  <target>:<class>  { ioctl(0x8910-0x8926)
>>> ioctl(0x892A) }
>>>
>>>
>> If you want additional syntax couldn't we move that burden to m4 rather
>> then making it a part of the compiler core?
>>
> 
> I haven't looked at the patches but the parser isn't going to be any
> more or less complex either way, so whatever looks better and is easier
> to generate is likely better.
> 
> These raw values really bother me, though. They make policy impossible
> to interpret if you do not have an intimate understanding of the
> drivers. Are these really permissions? It seems closer to Xen's labeling
> of memory addresses and pci devices.
> 
> For reference Xen policy labels various objects:
> pirqcon 33 system_u:object_r:nicP_t
> iomemcon 0xfebe0-0xfebff system_u:object_r:nicP_t
> iomemcon 0xfebd9 system_u:object_r:nicP_t
> ioportcon 0xecc0-0xecdf system_u:object_r:nicP_t
> pcidevicecon 0xc800 system_u:object_r:nicP_t
> 
> And uses standard TE rules to allow access.
> 
> Why not label ioctls and have an ioctl object class?

An early version of the patches tried that, but I advised against it.
ioctl commands are not objects/resources; they are actions and therefore
map to something like permissions.  Further, the object in these checks
is the device node security context and class, which reflects the
underlying driver, e.g. the GPU driver, the binder driver, the block
driver for the /system partition, etc.  IIRC, the early version of the
patch had two checks, the normal ioctl check against the device node
security context and a new check against the security context derived
from the ioctl command value, but the pairwise checking doesn't
necessarily give you the same control or expressiveness.
