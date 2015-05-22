Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MICpfR021413
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 14:12:51 -0400
Received: by obfe9 with SMTP id e9so18768890obf.1
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 11:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95BU9ExBt4S_8PQXw0en7ED-MzowG-zbdqwGEHh8o74YFA@mail.gmail.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAFftDdpuSc6qyAo8Zd8At+LodwUbNmdi2LGT7HurAfG68rEruQ@mail.gmail.com>
 <555DF171.10805@quarksecurity.com>
 <CAFftDdpayX=GqssXHxpfq8UTycJSfamGQdzqMWe9wYDfwwegvg@mail.gmail.com>
 <555DF24E.1060000@quarksecurity.com> <555DF546.80103@tycho.nsa.gov>
 <555DF952.1010008@quarksecurity.com>
 <CABXk95BU9ExBt4S_8PQXw0en7ED-MzowG-zbdqwGEHh8o74YFA@mail.gmail.com>
Date: Fri, 22 May 2015 14:12:32 -0400
Message-ID: <CAHC9VhRXncoJ=9+4f_dAJM8gS49PVAnG1WAMOfeJHdpzB0myEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 21, 2015 at 2:05 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Here is my personal todo list based on this conversation.
>
> - change example policy in commit message to demonstrate intended use.
> No raw ioctl values.
> - Look into making logic more general, less ioctl specific
> - Look at making the code clearer. I.e. address Paul's comments on
> lack of clarity in struct/variable naming.

Thanks.  That all sounds reasonable to me.

> In the spirit of keeping this commit concise and as basic as possible
> (it's already 800 LOC!) I will not address suggestions to propagate
> additional policy information such as ioctl names and groups into the
> kernel binary. I agree that would be useful, but I will leave as
> future work.

Agreed.

Also, if you want, you could probably split up patch 2/2 if you wanted
into a few more patches.  While the golden rule is that you can't
break anything with a single patch, e.g. it must still compile/boot,
it is perfectly fine to add non-functional code midway through a
patchset so long as everything is working and enabled by the time you
reach the end of the patchset.

> Regarding comments on policy syntax, those will be addressed in a
> separate non-kernel commit to the selinux project.
>
> Thanks again for all the feedback!

Thanks for the patches!
