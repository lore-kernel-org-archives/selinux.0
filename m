Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1NGFDxT009494
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 11:15:13 -0500
Received: by mail-lf0-f68.google.com with SMTP id o145so9873058lff.0
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 08:14:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519385820.10225.2.camel@btinternet.com>
References: <201802230851.puwlEkXk%fengguang.wu@intel.com>
 <1519385820.10225.2.camel@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2018 11:13:58 -0500
Message-ID: <CAHC9VhRUMUXOfMRmH7DGzNTQHEE5V8Wu3Xx8abtN6WPH3+60fA@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [pcmoore-selinux:next 5/5]
 security/selinux/include/netlabel.h:135:66: error: unknown type name 'sock'
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 23, 2018 at 6:37 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2018-02-23 at 08:21 +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selin
>> ux.git next
>> head:   db97c9f9d31217e3e133056fe2bea76639f87ec1
>> commit: db97c9f9d31217e3e133056fe2bea76639f87ec1 [5/5] selinux: Add
>> SCTP support
>> config: x86_64-allyesdebian (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>         git checkout db97c9f9d31217e3e133056fe2bea76639f87ec1
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All errors (new ones prefixed by >>):

...

> Paul,
> Would you like a new selinux-Add-SCTP-support.patch to fix this.

Yes please, that would save me having to fix them :)

I assume you've also seen the sparse warning email from the kbuild
robot?  We should fix that too.

-- 
paul moore
www.paul-moore.com
