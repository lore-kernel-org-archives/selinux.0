Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKHoLxD007998
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 12:50:22 -0500
Received: by mail-vk0-f65.google.com with SMTP id p9so15281508vkd.1
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 09:49:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTFcrPFa_z2g4Zh-tM0tYOX6UKMcQGGPzzm=-n2ss2crg@mail.gmail.com>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
 <a0eae335-02c5-8280-9c5c-d4a7b7c8228a@m4x.org>
 <1482157462.28570.2.camel@tycho.nsa.gov>
 <CAHC9VhTFcrPFa_z2g4Zh-tM0tYOX6UKMcQGGPzzm=-n2ss2crg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Dec 2016 12:49:52 -0500
Message-ID: <CAHC9VhQ9LvU1WcVDORTfA7UgbCQKYOON+NDZoGSLG8XsarbedQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 19, 2016 at 8:35 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Dec 19, 2016 at 9:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Sun, 2016-12-18 at 21:06 +0100, Nicolas Iooss wrote:
>>> Hello,
>>> This patch made the compiler I am using to build the kernel (clang)
>>> report two new warnings when building
>>> scripts/selinux/genheaders/genheaders.c and
>>> scripts/selinux/mdp/mdp.c:
>>>
>>> 'CAP_LAST_CAP' is not defined, evaluates to 0 [-Wundef]
>>> 'CAP_AUDIT_READ' is not defined, evaluates to 0 [-Wundef]
>>>
>>> Even though this is not detected by gcc, it seems like a bug to
>>> compare
>>> undefined values. There is no issue where classmap.h is included from
>>> security/selinux/avc.c because include/uapi/linux/capability.h got
>>> included too.
>>>
>>> I see two ways of fixing these warnings: either by defining the
>>> capability values in genheaders and mdp by adding #include
>>> <linux/capability.h>, or by adding "defined(__KERNEL__) &&" before
>>> the
>>> test so that it is only processed from kernel code (avc.c). How would
>>> you like this to be fixed?
>>
>> I suppose we ought to #include <uapi/linux/capability.h> in classmap.h.
>
> Yep.  Unless one of you wants to beat me to it, I'll put a quick patch
> together tomorrow.

See the patch I just posted to the list.  It turns out it wasn't quite
that easy due to conflicts between the kernel and system among the
various nested includes, but I think the posted patch should solve
everything, if not please let me know.  If I don't hear anything, I'll
push this up to James later this week (tomorrow?) for inclusion into
v4.10.

-- 
paul moore
www.paul-moore.com
