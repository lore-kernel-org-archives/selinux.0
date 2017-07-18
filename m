Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6I6jOXf000895
 for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2017 02:45:24 -0400
Received: by mail-it0-f48.google.com with SMTP id h199so8586491ith.1
 for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2017 23:45:22 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5jK-DYqBH8NE=BiTRZ7o5o3hjscLX=wRvmUtx8ktxf62CA@mail.gmail.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
 <1499673451-66160-3-git-send-email-keescook@chromium.org>
 <87a84cr7oc.fsf@xmission.com>
 <CAGXu5jLw6SsXM66x7ZHdj+Pb8Aepq7rHn1saNHRhq-wqk8p=4g@mail.gmail.com>
 <87bmosmcqv.fsf@xmission.com>
 <CAGXu5jK-DYqBH8NE=BiTRZ7o5o3hjscLX=wRvmUtx8ktxf62CA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 17 Jul 2017 23:45:20 -0700
Message-ID: <CAGXu5jL9cy8d9aRGEn=Jk+8Bs-0wJU4Bter_J-x6RdouHPCfgA@mail.gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>,
 Serge Hallyn <serge@hallyn.com>,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michal Hocko <mhocko@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
 Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>,
 James Morris <james.l.morris@oracle.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "<linux-security-module@vger.kernel.org>"
 <linux-security-module@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 2/8] exec: Move security_bprm_secureexec()
 earlier
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 10, 2017 at 7:07 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 10, 2017 at 10:18 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>>> On Mon, Jul 10, 2017 at 1:57 AM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>> Kees Cook <keescook@chromium.org> writes:
>>>>
>>>>> There are several places where exec needs to know if a privilege-gain has
>>>>> happened. These should be using the results of security_bprm_secureexec()
>>>>> but it is getting (needlessly) called very late.
>>>>
>>>> It is hard to tell at a glance but I believe this introduces a
>>>> regression.
>>>>
>>>> cap_bprm_set_creds is currently called before cap_bprm_secureexec and
>>>> it has a number of cases such as no_new_privs and ptrace that can result
>>>> in some of the precomputed credential changes not happening.
>>>>
>>>> Without accounting for that I believe your cap_bprm_securexec now
>>>> returns a postive value too early.
>>>
>>> It's still before cap_bprm_secureexec. cap_brpm_set_creds() is in
>>> prepare_binprm(), which is well before exec_binprm() and it's eventual
>>> call to setup_new_exec().
>>
>> Good point.  I didn't double check and the set in the name had me
>> thinking it was setting the creds on current.
>>
>> Is there any reason we need a second security hook?  It feels like we
>> should be able to just fold the secureexec hook into the set_creds hook.
>>
>> The two are so interrelated I fear that having them separate only
>> encourages them to diverge in trivial ways as it is easy to forget about
>> some detail or other.
>>
>> Certainly having them called from different functions seems wrong.  If
>> we know enough in prepare_binprm we know enough.
>
> Hmmm, yes. That would let us have the secureexec-ness knowledge before
> copy_strings(), in case we ever need to make that logic
> secureexec-aware.
>
> I'll dig through the LSMs to examine the set_creds hooks to see if
> this could be possible.

So, yes, after digging, this is very possible. In fact, it's highly
desirable. Both commoncaps and AppArmor save state into the bprm
struct between bprm_set_creds and bprm_secureexec explicitly to return
a sane value from bprm_secureexec. (And Smack and SELinux both have
trivial tests that just repeat from bprm_set_creds.)

I've reworked the series to just remove bprm_secureexec entirely. It
comes out nicely, removing more than it adds:

 14 files changed, 54 insertions(+), 144 deletions(-)

I'll send the patches in the morning (perhaps to go through -mm since
it touches fs/exec.c, binfmt_elf*.c, and security/).

-Kees

-- 
Kees Cook
Pixel Security
