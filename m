Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBK1NkFD021786
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 20:23:47 -0500
Received: by mail-vk0-f67.google.com with SMTP id w194so14056248vkw.3
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 17:23:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482184239.28570.68.camel@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
 <1482184239.28570.68.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Dec 2016 20:23:43 -0500
Message-ID: <CAHC9VhSK7nfsO4uKOSQAxgsHavZuE1afRoVx9qXFzxcO+DPC3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>,
 =?UTF-8?Q?Jos=C3=A9_Bollo?= <jobol@nonadev.net>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 19, 2016 at 4:50 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2016-12-19 at 13:25 -0800, Casey Schaufler wrote:
>> A brief look at the existing modules leads me to believe that
>> everyone ought to be happier if we moved the LSM task blob out
>> of the cred structure. SELinux keeps a small (6xu32) task blob
>> that has no reason to share and refcount. Smack has a couple of
>> lists in the task blob that really shouldn't be in the cred.
>> There would have to be some rework of the task_alloc and task_free
>> hooks to get the life of the blobs correct, but I think on the
>> whole it would be lots cleaner.
>
> Moving everything back to per-task security blob is inadvisable; the
> kernel now passes around cred structures, including to some of the
> security hooks, and you don't always want to check the credentials/sid
> of the current task (that's one of the reasons creds were introduced).

Casey, if you haven't looked at some of the stuff that we did recently
in SELinux for overlayfs, it might be a good idea to look at that,
especially with the world hurtling towards containers with wild
abandon.  I can't say I know exactly how it will affect Smack, but my
guess is that you will end up with something very similar to what we
do in SELinux.

> You could perhaps move the SIDs other than the current one (e.g.
> exec_sid, create_sid, ...) to the per-task security blob without
> harm/confusion, but it is unclear what you gain from doing so; then we
> would need to look in two places to find all the information we need
> for certain hooks rather than one.  And certainly we'd end up consuming
> more memory that way.

No thank you.

> No, I don't think we want SELinux changed in this regard.

Agreed.  I have no object if other LSMs want to add a security blob to
the task struct, I just don't want to see it replace the cred blobs.

-- 
paul moore
www.paul-moore.com
