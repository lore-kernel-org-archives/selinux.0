Subject: Re: SELinux sandbox escape via TIOCSTI ioctl
To: Paul Moore <paul@paul-moore.com>, up201407890@alunos.dcc.fc.up.pt
References: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
 <e6efcd0b-27cd-de33-d111-bc2bcb1dc0b1@tycho.nsa.gov>
 <20160924115740.18196b6yz71zn4kc@webmail.alunos.dcc.fc.up.pt>
 <CAHC9VhRAwGzNxz-4OofPLFKg5D-VvdSPGZWd9Gdoh4-0zB-8jA@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e330fa2a-f2e5-c79e-6bf3-324936554fe4@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 08:52:18 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRAwGzNxz-4OofPLFKg5D-VvdSPGZWd9Gdoh4-0zB-8jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2016 09:25 AM, Paul Moore wrote:
> On Sat, Sep 24, 2016 at 5:57 AM,  <up201407890@alunos.dcc.fc.up.pt> wrote:
>> Quoting "Stephen Smalley" <sds@tycho.nsa.gov>:
>>> Thank you for the bug report. This bug is now fixed in upstream commit
>>> acca96a135a4d2a028ba9b636886af99c0915379.
>>
>> Cool, thanks. Though it'll lose job control, that's why most 'su-like'
>> programs refuse to patch this and are still vulnerable.
> 
> I think we should wait and and see if people complain about the loss
> of job control; I'd rather see us fix the problem with TIOCSTI.
> 
>> Anyways, the same happens with the 'runcon' utility:
> 
> I don't think we need to fix this for runcon, as it isn't as
> sandboxing tool like sandbox, and the loss of job control would likely
> be much more noticeable for runcon.

FWIW, this issue can be addressed through policy without changes to
runcon in one of two ways:

1) Policy can prevent the new context from using the controlling tty at
all, in which case the kernel will reset the controlling tty
automatically (flush_unauthorized_files() in security/selinux/hooks.c),

2) Policy can allow the new context to read/write the tty but prevent
use of TIOCSTI in particular via the ioctl whitelisting support
introduced in Linux 4.3 and libsepol/checkpolicy 2.5.
