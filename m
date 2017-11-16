MIME-Version: 1.0
In-Reply-To: <CAHC9VhTuxTzTTB6PBesK1UktWbpQD_MN-w9J1S77Exn87-1AwA@mail.gmail.com>
References: <1510569641-28179-1-git-send-email-yamada.masahiro@socionext.com>
 <CAHC9VhTuxTzTTB6PBesK1UktWbpQD_MN-w9J1S77Exn87-1AwA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 16 Nov 2017 09:15:36 +0900
Message-ID: <CAK7LNAQs_pAbJckzhao5B4dfYkvRPGkne6Xkd3ne0jBoJ9d_rA@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: remove unnecessary assignment to
 subdir-
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-11-14 7:41 GMT+09:00 Paul Moore <paul@paul-moore.com>:
> On Mon, Nov 13, 2017 at 5:40 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Makefile.clean descends into $(subdir-y).  Dummy assignment to subdir-
>> is meaningless.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> I will pick this up for kbuild tree
>> since this is very trivial from the build system point of view.
>
> Okay, thanks.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>

Applied to linux-kbuild/kbuild.



-- 
Best Regards
Masahiro Yamada
