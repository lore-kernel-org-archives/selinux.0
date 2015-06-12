Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CKpquK022120
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 16:51:53 -0400
Received: by obpc2 with SMTP id c2so1926951obp.3
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 13:51:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95C-3OYrFTWcgOgj3iHqdv-=pi=5xcXtZCuOqc_8vOVSwQ@mail.gmail.com>
References: <1434124938-12477-1-git-send-email-jeffv@google.com>
 <CAHC9VhQCcod5LwMbEpYxvU7TFCtqOZqUK7wfgRS7nY305kYhXw@mail.gmail.com>
 <CABXk95C-3OYrFTWcgOgj3iHqdv-=pi=5xcXtZCuOqc_8vOVSwQ@mail.gmail.com>
Date: Fri, 12 Jun 2015 16:51:25 -0400
Message-ID: <CAHC9VhRFNs9W-Qv3PX7yL=77a9tjFr5VvjpyM5=9qFiGSN59iA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v6] selinux: extended permissions for ioctls
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 12, 2015 at 4:49 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Go ahead and just remove them. I normally do, but forgot. They're just
> tracking tags for android.

Okay, thanks.

> On Fri, Jun 12, 2015 at 1:46 PM, Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Fri, Jun 12, 2015 at 12:02 PM, Jeff Vander Stoep <jeffv@google.com>
>> wrote:
>> > Add extended permissions logic to selinux. Extended permissions
>> > provides additional permissions in 256 bit increments. Extend the
>> > generic ioctl permission check to use the extended permissions for
>> > per-command filtering. Source/target/class sets including the ioctl
>> > permission may additionally include a set of commands. Example:
>> >
>> > allowxperm <source> <target>:<class> ioctl unpriv_app_socket_cmds
>> > auditallowxperm <source> <target>:<class> ioctl priv_gpu_cmds
>> >
>> > Where unpriv_app_socket_cmds and priv_gpu_cmds are macros
>> > representing commonly granted sets of ioctl commands.
>> >
>> > When ioctl commands are omitted only the permissions are checked.
>> > This feature is intended to provide finer granularity for the ioctl
>> > permission that may be too imprecise. For example, the same driver
>> > may use ioctls to provide important and benign functionality such as
>> > driver version or socket type as well as dangerous capabilities such
>> > as debugging features, read/write/execute to physical memory or
>> > access to sensitive data. Per-command filtering provides a mechanism
>> > to reduce the attack surface of the kernel, and limit applications
>> > to the subset of commands required.
>> >
>> > The format of the policy binary has been modified to include ioctl
>> > commands, and the policy version number has been incremented to
>> > POLICYDB_VERSION_XPERMS_IOCTL=30 to account for the format
>> > change.
>> >
>> > The extended permissions logic is deliberately generic to allow
>> > components to be reused e.g. netlink filters
>> >
>> > Bug: 19416735
>> > Change-Id: Ibd462f12ba5748cf5dd91f28e5795764363121a2
>> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>> > ---
>> > v6 adds ommitted function comment header entries for avc_update_node
>> >
>> >  security/selinux/avc.c              | 415
>> > ++++++++++++++++++++++++++++++++++--
>> >  security/selinux/hooks.c            |  42 +++-
>> >  security/selinux/include/avc.h      |   6 +
>> >  security/selinux/include/security.h |  32 ++-
>> >  security/selinux/ss/avtab.c         | 104 +++++++--
>> >  security/selinux/ss/avtab.h         |  33 ++-
>> >  security/selinux/ss/conditional.c   |  32 ++-
>> >  security/selinux/ss/conditional.h   |   6 +-
>> >  security/selinux/ss/policydb.c      |   5 +
>> >  security/selinux/ss/services.c      | 213 ++++++++++++++++--
>> >  security/selinux/ss/services.h      |   6 +
>> >  11 files changed, 834 insertions(+), 60 deletions(-)
>>
>> Also applied to the SELinux next-queue, thank you.
>>
>> However, can you explain the "Bug" and "Change-Id" headers in your
>> patch description above?  They are horribly generic and I'd like to
>> remove them from the sign-off or at least provide a more descriptive
>> name in order to limit the confusion.  For example, could we provide a
>> URL instead of a bug ID#?  Could it be an Android-Change-Id (or
>> similar)?
>>
>> --
>> paul moore
>> www.paul-moore.com
>
>



-- 
paul moore
www.paul-moore.com
