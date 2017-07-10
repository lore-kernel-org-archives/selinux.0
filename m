Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6AG4JNC025034
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 12:04:20 -0400
Received: by mail-it0-f50.google.com with SMTP id k192so44268800ith.1
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 09:04:17 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87van0r86d.fsf@xmission.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
 <1499673451-66160-2-git-send-email-keescook@chromium.org>
 <87van0r86d.fsf@xmission.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 10 Jul 2017 09:04:15 -0700
Message-ID: <CAGXu5jKTaXLU+H6DnNuy6ggxcMDgo9G-wEmZ4RP=QneJaZuNDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] exec: Correct comments about "point of no return"
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
 linux-security-module <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 10, 2017 at 1:46 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> But you miss it.
>
> The "point of no return" is the call to de_thread.  Or aguably anything in
> flush_old_exec.  Once anything in the current task is modified you can't
> return an error.
>
> It very much does not have anything to do with brpm.    It has
> everything to do with current.

Yes, but the thing that actually enforces this is the test of bprm->mm
and the SIGSEGV in search_binary_handlers().

-Kees

>
>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 904199086490..7842ae661e34 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1285,7 +1285,14 @@ int flush_old_exec(struct linux_binprm * bprm)
>>       if (retval)
>>               goto out;
>>
>> -     bprm->mm = NULL;                /* We're using it now */
>> +     /*
>> +      * After clearing bprm->mm (to mark that current is using the
>> +      * prepared mm now), we are at the point of no return. If
>> +      * anything from here on returns an error, the check in
>> +      * search_binary_handler() will kill current (since the mm has
>> +      * been replaced).
>> +      */
>> +     bprm->mm = NULL;
>>
>>       set_fs(USER_DS);
>>       current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
>
> Eric



-- 
Kees Cook
Pixel Security
