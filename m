Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
 <a0eae335-02c5-8280-9c5c-d4a7b7c8228a@m4x.org>
 <1482157462.28570.2.camel@tycho.nsa.gov>
 <CAHC9VhTFcrPFa_z2g4Zh-tM0tYOX6UKMcQGGPzzm=-n2ss2crg@mail.gmail.com>
 <CAHC9VhQ9LvU1WcVDORTfA7UgbCQKYOON+NDZoGSLG8XsarbedQ@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <19089088-d2a4-feab-81df-71854b232fba@m4x.org>
Date: Wed, 21 Dec 2016 16:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ9LvU1WcVDORTfA7UgbCQKYOON+NDZoGSLG8XsarbedQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 20/12/16 18:49, Paul Moore wrote:
> On Mon, Dec 19, 2016 at 8:35 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Dec 19, 2016 at 9:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On Sun, 2016-12-18 at 21:06 +0100, Nicolas Iooss wrote:
>>>> Hello,
>>>> This patch made the compiler I am using to build the kernel (clang)
>>>> report two new warnings when building
>>>> scripts/selinux/genheaders/genheaders.c and
>>>> scripts/selinux/mdp/mdp.c:
>>>>
>>>> 'CAP_LAST_CAP' is not defined, evaluates to 0 [-Wundef]
>>>> 'CAP_AUDIT_READ' is not defined, evaluates to 0 [-Wundef]
>>>>
>>>> Even though this is not detected by gcc, it seems like a bug to
>>>> compare
>>>> undefined values. There is no issue where classmap.h is included from
>>>> security/selinux/avc.c because include/uapi/linux/capability.h got
>>>> included too.
>>>>
>>>> I see two ways of fixing these warnings: either by defining the
>>>> capability values in genheaders and mdp by adding #include
>>>> <linux/capability.h>, or by adding "defined(__KERNEL__) &&" before
>>>> the
>>>> test so that it is only processed from kernel code (avc.c). How would
>>>> you like this to be fixed?
>>>
>>> I suppose we ought to #include <uapi/linux/capability.h> in classmap.h.
>>
>> Yep.  Unless one of you wants to beat me to it, I'll put a quick patch
>> together tomorrow.
> 
> See the patch I just posted to the list.  It turns out it wasn't quite
> that easy due to conflicts between the kernel and system among the
> various nested includes, but I think the posted patch should solve
> everything, if not please let me know.  If I don't hear anything, I'll
> push this up to James later this week (tomorrow?) for inclusion into
> v4.10.

Hello,
I confirm the patch you posted fixed the warnings I had. Nevertheless
when I take a look at which file got included by
scripts/selinux/mdp/mdp.c, it appears that classmap.h includes the
system header /usr/include/linux/capability.h instead of
include/uapi/linux/capability.h (unlike genheaders, which included the
last file). Is this something you wanted?

Thanks!
Nicolas
