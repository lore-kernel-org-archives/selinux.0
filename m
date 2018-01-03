Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w03JkuGJ000688
 for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2018 14:46:56 -0500
Received: by mail-io0-f169.google.com with SMTP id 14so3228244iou.2
 for <selinux@tycho.nsa.gov>; Wed, 03 Jan 2018 11:45:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a1054b8f-cebf-6c4b-be08-524d948b2449@schaufler-ca.com>
References: <20180103012017.7022-1-mjg59@google.com>
 <20180103012017.7022-2-mjg59@google.com>
 <cd89f3cf-b620-b098-a3db-c53f05d330bf@schaufler-ca.com>
 <CACdnJuv7ADizvK8omRJA244N65ReYqWT2HSS_T=_uV66wMZ6Sg@mail.gmail.com>
 <a1054b8f-cebf-6c4b-be08-524d948b2449@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 3 Jan 2018 11:44:46 -0800
Message-ID: <CACdnJus+EFtxrCH7RiKMtNqhm9CqWrvv9SviC7hncFB=8g4pew@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 LSM List <linux-security-module@vger.kernel.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V4 2/3] IMA: Use consistent creds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 3, 2018 at 11:32 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/3/2018 10:11 AM, Matthew Garrett wrote:
>> The problem here is that we don't *have* the task secid for one of the
>> cases I care about. Validating the task secid at execution time gives
>> us the security context of the spawning process, rather than the
>> spawned one - by the time it's committed to the task structure, it's
>> too late to block execution, so all we have is the secid associated
>> with the creds in the bprm structure. Obviously fixing this in a way
>> that doesn't break your work is important, so any suggestions on how I
>> should be fixing this? :)
>
> A security module is allowed to manage either or both of
> task and cred blobs. How a security module uses secids is
> completely up to the module. So far, everyone is using the
> secid to be an alias for the secctx, and the task and cred
> are treated as (roughly) the same kind of thing. But that's
> not guaranteed going forward. I don't know what someone
> might want to do that would cause a problem, but people are
> amazingly creative.
>
> I'm actually more concerned with the IMA code using the audit
> rule matching. There's an assumption that the secid from a
> cred and a secid from a task are both acceptable to the audit
> system. What if they aren't? It's possible that I'm just
> being paranoid, but we're getting too many permutations
> (audit/IMA + task/cred) for my liking.

The idea here is that we want to be able to trigger an IMA rule
conditionally based on the LSM context a process is running under at
exec time. The current code does so using the secid of current, which
means we're determining whether the new binary should be measured
based on the security context of the task that's executing it.
However, we want to be able to do so based on the security context of
the task that's being executed (usecase here is that I want to measure
anything that's executed in a privileged security context, but don't
care about anything that's running in an unprivileged context). The
child secid has been calculated and put in the creds that are present
in the bprm structure, but commit_creds() hasn't been called yet and
as a result they're not associated with the task struct. One of the
outcomes of measurement may be to block execution, and unfortunately
by the time commit_creds() has been called it's too late to do so.

If we want to be able to do something conditional on the LSM context
that a process is going to be executed under, *before* commit_creds()
is called, is there an existing way to do so? I can rework this so we
use the task secid for all running processes and the cred secid for
the not-yet-running child process, but I don't know if that's
sufficient to avoid problems in future.
