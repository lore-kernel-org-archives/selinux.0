From: ebiederm@xmission.com (Eric W. Biederman)
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, David Howells <dhowells@redhat.com>, Serge Hallyn
 <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Michal Hocko <mhocko@kernel.org>, Ben
 Hutchings <ben@decadent.org.uk>, Hugh Dickins <hughd@google.com>, Oleg
 Nesterov <oleg@redhat.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik
 van Riel <riel@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Smalley
 <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Vivek Goyal
 <vgoyal@redhat.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "<linux-security-module@vger.kernel.org>"
 <linux-security-module@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
 <1499673451-66160-2-git-send-email-keescook@chromium.org>
 <87van0r86d.fsf@xmission.com>
 <CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
Date: Mon, 10 Jul 2017 12:07:06 -0500
In-Reply-To: <CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
 (Kees Cook's message of "Mon, 10 Jul 2017 09:04:15 -0700")
Message-ID: <87pod8mdad.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 1/8] exec: Correct comments about "point of no return"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Kees Cook <keescook@chromium.org> writes:

> On Mon, Jul 10, 2017 at 1:46 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> But you miss it.
>>
>> The "point of no return" is the call to de_thread.  Or aguably anything in
>> flush_old_exec.  Once anything in the current task is modified you can't
>> return an error.
>>
>> It very much does not have anything to do with brpm.    It has
>> everything to do with current.
>
> Yes, but the thing that actually enforces this is the test of bprm->mm
> and the SIGSEGV in search_binary_handlers().

So what.  Calling that the point of no return is wrong.

The point of no return is when we kill change anyting in signal_struct
or task_struct.  AKA killing the first thread in de_thread.

It is more than just the SIGSEGV in search_binary_handlers that enforces
this.  de_thread only returns (with a failure code) after having killed
some threads if those threads are dead.

Similarly exec_mmap only returns with failure if we know that a core
dump is pending, and as such the process will be killed before returning
to userspace.

I am a little worried that we may fail to dump some threads if a core
dump races with exec, but that is a quality of implementation issue, and
the window is very small so I don't know that it matters.

The point of no return very much comes a while before clearing brpm->mm.

>>> diff --git a/fs/exec.c b/fs/exec.c
>>> index 904199086490..7842ae661e34 100644
>>> --- a/fs/exec.c
>>> +++ b/fs/exec.c
>>> @@ -1285,7 +1285,14 @@ int flush_old_exec(struct linux_binprm * bprm)
>>>       if (retval)
>>>               goto out;
>>>
>>> -     bprm->mm = NULL;                /* We're using it now */
>>> +     /*
>>> +      * After clearing bprm->mm (to mark that current is using the
>>> +      * prepared mm now), we are at the point of no return. If
>>> +      * anything from here on returns an error, the check in
>>> +      * search_binary_handler() will kill current (since the mm has
>>> +      * been replaced).
>>> +      */
>>> +     bprm->mm = NULL;
>>>
>>>       set_fs(USER_DS);
>>>       current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |

Eric
