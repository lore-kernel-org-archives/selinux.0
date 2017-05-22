Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MLJBdk012921
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 17:19:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id h4so6452845lfj.3
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 14:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB167871B25F7C3AE49878F3ADC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <201705211751.KBNIRg9i%fengguang.wu@intel.com>
 <CAHC9VhQ3_cKwdY-b_1vuT840aGbe6eJq6iFtt_NVuFXitB9wUQ@mail.gmail.com>
 <VI1PR05MB167871B25F7C3AE49878F3ADC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 May 2017 17:19:07 -0400
Message-ID: <CAHC9VhTX_0HYrMzJVv7VNpaEswFGUwUeixt0U=Fx3Eh2ZDrG3g@mail.gmail.com>
Subject: Re: [pcmoore-selinux:next 17/17] security/selinux/ibpkey.c:116:24:
 sparse: incompatible types in comparison expression (different address spaces)
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 kbuild test robot <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 22, 2017 at 5:16 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 5/22/2017 4:06 PM, Paul Moore wrote:
>> On Sun, May 21, 2017 at 5:47 AM, kbuild test robot
>> <fengguang.wu@intel.com> wrote:
>>> tree:   git://git.infradead.org/users/pcmoore/selinux next
>>> head:   b76dd295790d44ecb04932110309bb6c15f263a8
>>> commit: b76dd295790d44ecb04932110309bb6c15f263a8 [17/17] selinux: Add a cache for quicker retreival of PKey SIDs
>>> reproduce:
>>>         # apt-get install sparse
>>>         git checkout b76dd295790d44ecb04932110309bb6c15f263a8
>>>         make ARCH=x86_64 allmodconfig
>>>         make C=1 CF=-D__CHECK_ENDIAN__
>>>
>>>
>>> sparse warnings: (new ones prefixed by >>)
>>>
>>>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>>>>> security/selinux/ibpkey.c:116:24: sparse: incompatible types in comparison expression (different address spaces)
>> I haven't looked at this too closely, but this may not be significant
>> ... Daniel, can you look into this please?
>
> I looked at this before.  I don't believe it's significant.  The same warning pops up in security/selinux/netport.c:125.

Yes, part two of my request was going to have you also fix it for
netport.c, but it looks like you've dodged that request for now ;)

-- 
paul moore
www.paul-moore.com
