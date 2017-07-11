Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6B27eGd029231
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 22:07:40 -0400
Received: by mail-it0-f49.google.com with SMTP id m84so5733222ita.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 19:07:39 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87bmosmcqv.fsf@xmission.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
 <1499673451-66160-3-git-send-email-keescook@chromium.org>
 <87a84cr7oc.fsf@xmission.com>
 <CAGXu5jLw6SsXM66x7ZHdj+Pb8Aepq7rHn1saNHRhq-wqk8p=4g@mail.gmail.com>
 <87bmosmcqv.fsf@xmission.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 10 Jul 2017 19:07:37 -0700
Message-ID: <CAGXu5jK-DYqBH8NE=BiTRZ7o5o3hjscLX=wRvmUtx8ktxf62CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] exec: Move security_bprm_secureexec() earlier
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
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 10, 2017 at 10:18 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Mon, Jul 10, 2017 at 1:57 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Kees Cook <keescook@chromium.org> writes:
>>>
>>>> There are several places where exec needs to know if a privilege-gain has
>>>> happened. These should be using the results of security_bprm_secureexec()
>>>> but it is getting (needlessly) called very late.
>>>
>>> It is hard to tell at a glance but I believe this introduces a
>>> regression.
>>>
>>> cap_bprm_set_creds is currently called before cap_bprm_secureexec and
>>> it has a number of cases such as no_new_privs and ptrace that can result
>>> in some of the precomputed credential changes not happening.
>>>
>>> Without accounting for that I believe your cap_bprm_securexec now
>>> returns a postive value too early.
>>
>> It's still before cap_bprm_secureexec. cap_brpm_set_creds() is in
>> prepare_binprm(), which is well before exec_binprm() and it's eventual
>> call to setup_new_exec().
>
> Good point.  I didn't double check and the set in the name had me
> thinking it was setting the creds on current.
>
> Is there any reason we need a second security hook?  It feels like we
> should be able to just fold the secureexec hook into the set_creds hook.
>
> The two are so interrelated I fear that having them separate only
> encourages them to diverge in trivial ways as it is easy to forget about
> some detail or other.
>
> Certainly having them called from different functions seems wrong.  If
> we know enough in prepare_binprm we know enough.

Hmmm, yes. That would let us have the secureexec-ness knowledge before
copy_strings(), in case we ever need to make that logic
secureexec-aware.

I'll dig through the LSMs to examine the set_creds hooks to see if
this could be possible.

-Kees

-- 
Kees Cook
Pixel Security
