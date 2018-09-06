Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w86JaRGK005523
 for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2018 15:36:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so5722207pgp.11
 for <selinux@tycho.nsa.gov>; Thu, 06 Sep 2018 12:36:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a6Y1N1VbpLoJPyK5DFYyr8RGM_=mqpWwina=yTUEtUvg@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
 <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
 <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <CACT4Y+a6Y1N1VbpLoJPyK5DFYyr8RGM_=mqpWwina=yTUEtUvg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 6 Sep 2018 21:35:58 +0200
Message-ID: <CACT4Y+YiwOyM7P7jTYi5k7jeycKj=aW+yi0r+jvpqKJ4FjypLA@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 SELinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
 Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 6, 2018 at 1:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Sep 6, 2018 at 12:59 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
>>>> Thanks! I've re-enabled selinux on syzbot:
>>>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
>>>> Now we will have instances with apparmor and with selinux.
>>>
>>> Any chance we could get a Smack instance as well?
>>
>> Hi Casey,
>>
>> Sure!
>> Provided you want to fix bugs ;)
>> I've setup an instance with smack enabled:
>> https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee
>
>
> But just doing default things does not seem to find much. I guess
> common paths through the hooks are well exercised already.
> So perhaps if we do more non-trivial things, it can find more stuff.
> But what are they? Adding/changing/removing xattr's? Which? What are
> the values? Changing security contexts? How? What else?
> selinux has own filesystem and we should touch some files there:
> https://github.com/google/syzkaller/blob/master/sys/linux/selinux.txt
> But we don't anything similar for other modules.


First one that looks smack-specific:
https://syzkaller.appspot.com/bug?id=9eda6092f146cb23cb9109f675a2e2cb743ee48b
