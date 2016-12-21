Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLFGIO3028884
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 10:16:19 -0500
Received: by mail-ua0-f196.google.com with SMTP id y22so2563595uay.0
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 07:16:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482303877.2199.0.camel@nonadev.net>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhTCtL3nT1ThPK9aa0fgVQYphk0Ax3xXSf0SbUSr33XC7Q@mail.gmail.com>
 <1482303877.2199.0.camel@nonadev.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Dec 2016 10:15:59 -0500
Message-ID: <CAHC9VhRLbudFKOdn2SVByG1hUg324vv9Xn-mWDXFn8DuJOw2Og@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: =?UTF-8?Q?Jos=C3=A9_Bollo?= <jobol@nonadev.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 21, 2016 at 2:04 AM, José Bollo <jobol@nonadev.net> wrote:
> Le mardi 20 décembre 2016 à 21:37 -0500, Paul Moore a écrit :
>> On Fri, Dec 16, 2016 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > Processes can only alter their own security attributes via
>> > /proc/pid/attr nodes.  This is presently enforced by each
>> > individual
>> > security module and is also imposed by the Linux credentials
>> > implementation, which only allows a task to alter its own
>> > credentials.
>> > Move the check enforcing this restriction from the individual
>> > security modules to proc_pid_attr_write() before calling the
>> > security hook,
>> > and drop the unnecessary task argument to the security hook since
>> > it can
>> > only ever be the current task.
>> >
>> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  fs/proc/base.c             | 13 +++++++++----
>> >  include/linux/lsm_hooks.h  |  3 +--
>> >  include/linux/security.h   |  4 ++--
>> >  security/apparmor/lsm.c    |  7 ++-----
>> >  security/security.c        |  4 ++--
>> >  security/selinux/hooks.c   | 13 +------------
>> >  security/smack/smack_lsm.c | 11 +----------
>> >  7 files changed, 18 insertions(+), 37 deletions(-)
>>
>> Merged into the selinux#next branch.
>
> is it fair?

I believe so, yes.  As many have already mentioned, this patch doesn't
introduce a new restriction, it simply cleans up an existing
restriction.  If/when PTAGS is merged upstream it can make any changes
needed as long as those changes do not cause a regression in the
safety or behavior of the existing LSMs and the kernel as a whole.

-- 
paul moore
www.paul-moore.com
