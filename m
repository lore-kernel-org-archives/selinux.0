Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLFcwNb003389
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 10:39:00 -0500
Received: by mail-ua0-f193.google.com with SMTP id 50so18806411uae.2
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 07:38:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <19089088-d2a4-feab-81df-71854b232fba@m4x.org>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
 <a0eae335-02c5-8280-9c5c-d4a7b7c8228a@m4x.org>
 <1482157462.28570.2.camel@tycho.nsa.gov>
 <CAHC9VhTFcrPFa_z2g4Zh-tM0tYOX6UKMcQGGPzzm=-n2ss2crg@mail.gmail.com>
 <CAHC9VhQ9LvU1WcVDORTfA7UgbCQKYOON+NDZoGSLG8XsarbedQ@mail.gmail.com>
 <19089088-d2a4-feab-81df-71854b232fba@m4x.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Dec 2016 10:38:56 -0500
Message-ID: <CAHC9VhQiC-yfQkv6CEqNpT3ut54BszzEOzhPzD4a_wDk3f-5KA@mail.gmail.com>
Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 21, 2016 at 10:07 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On 20/12/16 18:49, Paul Moore wrote:
>> See the patch I just posted to the list.  It turns out it wasn't quite
>> that easy due to conflicts between the kernel and system among the
>> various nested includes, but I think the posted patch should solve
>> everything, if not please let me know.  If I don't hear anything, I'll
>> push this up to James later this week (tomorrow?) for inclusion into
>> v4.10.
>
> Hello,
> I confirm the patch you posted fixed the warnings I had. Nevertheless
> when I take a look at which file got included by
> scripts/selinux/mdp/mdp.c, it appears that classmap.h includes the
> system header /usr/include/linux/capability.h instead of
> include/uapi/linux/capability.h (unlike genheaders, which included the
> last file). Is this something you wanted?

Probably not, thanks for pointing this out; give me a few minutes and
I'll post a v2 patch.

-- 
paul moore
www.paul-moore.com
