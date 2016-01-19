Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0JGWZq7026376
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 11:32:37 -0500
Received: by mail-oi0-f67.google.com with SMTP id x140so14337666oif.1
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 08:32:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453219908.2521.118.camel@linux.intel.com>
References: <1449259655-84458-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHC9VhS5yqpvi0Cdvm_MnConoaupf7XybwYS6uFLY+FYeHk=4w@mail.gmail.com>
 <1453219908.2521.118.camel@linux.intel.com>
Date: Tue, 19 Jan 2016 11:32:34 -0500
Message-ID: <CAHC9VhTba5kaFusm4sR9uuDr=qK9QMmQYUZYp9=hcwLkk+TynQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux: use absolute path to include directory
From: Paul Moore <paul@paul-moore.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 19, 2016 at 11:11 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-01-19 at 10:53 -0500, Paul Moore wrote:
>> On Fri, Dec 4, 2015 at 3:07 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > Compiler warns us a lot that it can't find include folder because
>> > it's provided
>> > in relative form.
>> >
>> >   CC      security/selinux/netlabel.o
>> > cc1: warning: security/selinux/include: No such file or directory
>> > [-Wmissing-include-dirs]
>> > cc1: warning: security/selinux/include: No such file or directory
>> > [-Wmissing-include-dirs]
>> > cc1: warning: security/selinux/include: No such file or directory
>> > [-Wmissing-include-dirs]
>> > cc1: warning: security/selinux/include: No such file or directory
>> > [-Wmissing-include-dirs]
>> >
>> > Add $(srctree) prefix to the path.
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > ---
>> >  security/selinux/Makefile | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
>> > index ad5cd76..90d1adb 100644
>> > --- a/security/selinux/Makefile
>> > +++ b/security/selinux/Makefile
>> > @@ -13,7 +13,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>> >
>> >  selinux-$(CONFIG_NETLABEL) += netlabel.o
>> >
>> > -ccflags-y := -Isecurity/selinux -Isecurity/selinux/include
>> > +ccflags-y := -Isecurity/selinux
>> > -I$(srctree)/security/selinux/include
>>
>> Why not add the $(srctree) prefix to both paths?
>
> I don't care as long as it fixes the annoying messages. Though, I can
> re-do the patch if it looks better that way.

Please do.

-- 
paul moore
www.paul-moore.com
