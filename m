Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBK1aDL3025406
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 20:36:13 -0500
Received: by mail-ua0-f194.google.com with SMTP id 50so13507238uae.2
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 17:35:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482157462.28570.2.camel@tycho.nsa.gov>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
 <a0eae335-02c5-8280-9c5c-d4a7b7c8228a@m4x.org>
 <1482157462.28570.2.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Dec 2016 20:35:18 -0500
Message-ID: <CAHC9VhTFcrPFa_z2g4Zh-tM0tYOX6UKMcQGGPzzm=-n2ss2crg@mail.gmail.com>
Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 19, 2016 at 9:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2016-12-18 at 21:06 +0100, Nicolas Iooss wrote:
>> On 18/11/16 16:23, Stephen Smalley wrote:
>> >
>> > When a new capability is defined, SELinux needs to be updated.
>> > Trigger a build error if a new capability is defined without
>> > corresponding update to security/selinux/include/classmap.h's
>> > COMMON_CAP2_PERMS.  This is similar to BUILD_BUG_ON() guards
>> > in the SELinux nlmsgtab code to ensure that SELinux tracks
>> > new netlink message types as needed.
>> >
>> > Note that there is already a similar build guard in
>> > security/selinux/hooks.c to detect when more than 64
>> > capabilities are defined, since that will require adding
>> > a third capability class to SELinux.
>> >
>> > A nicer way to do this would be to extend
>> > scripts/selinux/genheaders
>> > or a similar tool to auto-generate the necessary definitions and
>> > code
>> > for SELinux capability checking from
>> > include/uapi/linux/capability.h.
>> > AppArmor does something similar in its Makefile, although it only
>> > needs to generate a single table of names.  That is left as future
>> > work.
>> >
>> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  security/selinux/include/classmap.h | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/security/selinux/include/classmap.h
>> > b/security/selinux/include/classmap.h
>> > index 1f1f4b2..e2d4ad3a 100644
>> > --- a/security/selinux/include/classmap.h
>> > +++ b/security/selinux/include/classmap.h
>> > @@ -24,6 +24,10 @@
>> >  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog",
>> > \
>> >             "wake_alarm", "block_suspend", "audit_read"
>> >
>> > +#if CAP_LAST_CAP > CAP_AUDIT_READ
>> > +#error New capability defined, please update COMMON_CAP2_PERMS.
>> > +#endif
>> > +
>> >  /*
>> >   * Note: The name for any socket class should be suffixed by
>> > "socket",
>> >   *  and doesn't contain more than one substr of "socket".
>> >
>>
>> Hello,
>> This patch made the compiler I am using to build the kernel (clang)
>> report two new warnings when building
>> scripts/selinux/genheaders/genheaders.c and
>> scripts/selinux/mdp/mdp.c:
>>
>> 'CAP_LAST_CAP' is not defined, evaluates to 0 [-Wundef]
>> 'CAP_AUDIT_READ' is not defined, evaluates to 0 [-Wundef]
>>
>> Even though this is not detected by gcc, it seems like a bug to
>> compare
>> undefined values. There is no issue where classmap.h is included from
>> security/selinux/avc.c because include/uapi/linux/capability.h got
>> included too.
>>
>> I see two ways of fixing these warnings: either by defining the
>> capability values in genheaders and mdp by adding #include
>> <linux/capability.h>, or by adding "defined(__KERNEL__) &&" before
>> the
>> test so that it is only processed from kernel code (avc.c). How would
>> you like this to be fixed?
>
> I suppose we ought to #include <uapi/linux/capability.h> in classmap.h.

Yep.  Unless one of you wants to beat me to it, I'll put a quick patch
together tomorrow.

-- 
paul moore
www.paul-moore.com
