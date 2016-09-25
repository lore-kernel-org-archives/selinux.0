Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8PDQ0Mm021358
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 09:26:00 -0400
Received: by mail-vk0-f50.google.com with SMTP id 192so23034667vkl.2
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 06:25:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160924115740.18196b6yz71zn4kc@webmail.alunos.dcc.fc.up.pt>
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
 <e6efcd0b-27cd-de33-d111-bc2bcb1dc0b1@tycho.nsa.gov>
 <20160924115740.18196b6yz71zn4kc@webmail.alunos.dcc.fc.up.pt>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 25 Sep 2016 09:25:58 -0400
Message-ID: <CAHC9VhRAwGzNxz-4OofPLFKg5D-VvdSPGZWd9Gdoh4-0zB-8jA@mail.gmail.com>
Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: up201407890@alunos.dcc.fc.up.pt
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Sep 24, 2016 at 5:57 AM,  <up201407890@alunos.dcc.fc.up.pt> wrote:
> Quoting "Stephen Smalley" <sds@tycho.nsa.gov>:
>> Thank you for the bug report. This bug is now fixed in upstream commit
>> acca96a135a4d2a028ba9b636886af99c0915379.
>
> Cool, thanks. Though it'll lose job control, that's why most 'su-like'
> programs refuse to patch this and are still vulnerable.

I think we should wait and and see if people complain about the loss
of job control; I'd rather see us fix the problem with TIOCSTI.

> Anyways, the same happens with the 'runcon' utility:

I don't think we need to fix this for runcon, as it isn't as
sandboxing tool like sandbox, and the loss of job control would likely
be much more noticeable for runcon.

-- 
paul moore
www.paul-moore.com
