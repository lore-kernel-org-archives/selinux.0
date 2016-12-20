Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBK1q2Cg029110
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 20:52:02 -0500
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQOjXUYxRaHcgxwiTFwwNsUuf646O-gDq7Bm_0aToMtgQ@mail.gmail.com>
 <28224bb8-425e-5dec-472f-105c5cd7e098@schaufler-ca.com>
 <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
Cc: john.johansen@canonical.com, James Morris <james.l.morris@oracle.com>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1212df28-3cda-fcff-ab7e-f0f0a8e3493c@schaufler-ca.com>
Date: Mon, 19 Dec 2016 17:51:56 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/19/2016 5:30 PM, Paul Moore wrote:
> On Fri, Dec 16, 2016 at 5:13 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/16/2016 2:06 PM, Paul Moore wrote:
>>> On Fri, Dec 16, 2016 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> Processes can only alter their own security attributes via
>>>> /proc/pid/attr nodes.  This is presently enforced by each individual
>>>> security module and is also imposed by the Linux credentials
>>>> implementation, which only allows a task to alter its own credentials.
>>>> Move the check enforcing this restriction from the individual
>>>> security modules to proc_pid_attr_write() before calling the security hook,
>>>> and drop the unnecessary task argument to the security hook since it can
>>>> only ever be the current task.
>>>>
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>>  fs/proc/base.c             | 13 +++++++++----
>>>>  include/linux/lsm_hooks.h  |  3 +--
>>>>  include/linux/security.h   |  4 ++--
>>>>  security/apparmor/lsm.c    |  7 ++-----
>>>>  security/security.c        |  4 ++--
>>>>  security/selinux/hooks.c   | 13 +------------
>>>>  security/smack/smack_lsm.c | 11 +----------
>>>>  7 files changed, 18 insertions(+), 37 deletions(-)
>>> Looks good to me.  I'm happy to pull this in via the SELinux tree
>>> unless anyone else would rather take it?
>> That works for me. It does need to go in atomically.
> Even with all the discussion today, I still think this patch has value
> and I don't believe it should impact the PTAGS work as there are
> clearly larger issues that need to be resolved (e.g. reintroduce a
> task based security blob?).  Unless I hear any objections that this
> will wreck everything for years to come (very doubtful), I'll go ahead
> and merge this into the SELinux tree tomorrow.

I think this can go ahead without causing the end of western civilization.
