Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3OF2nB2011743
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 11:02:49 -0400
Received: by obfe9 with SMTP id e9so39677752obf.1
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 08:02:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQK8aO-1oP+XxC19ytP_ZFdCnkX=_x87YpEAdxGEtTTzg@mail.gmail.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <CAHC9VhQK8aO-1oP+XxC19ytP_ZFdCnkX=_x87YpEAdxGEtTTzg@mail.gmail.com>
Date: Fri, 24 Apr 2015 08:02:48 -0700
Message-ID: <CABXk95AWJt=S71qey9kegdX3d8UrmXTLqpdgEM84FEGbZuSp0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks Paul. I wasn't anticipating much feedback until the userspace
changes were submitted. Just got those in on Wednesday. Let me know if
there is anything else I can provide.

On Thu, Apr 23, 2015 at 3:28 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 9, 2015 at 5:48 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
>> ---- motivation ----
>> Ioctls provide many of the operations necessary for device control. The typical
>> driver supports a device specific set of operations accessible by the ioctl
>> system call and specified by the command argument. SELinux provides per
>> operation access control to many system operations e.g. chown, kill, setuid,
>> ipc_lock, etc. Ioclts on the other hand are granted on a per file descriptor
>> basis using the ioctl permission, meaning that the set of operations provided
>> by the driver are granted on an all-or-nothing basis. In some cases this may be
>> acceptable, but often the same driver provides a large and diverse set of
>> operations such as benign and necessary functionality as well as dangerous
>> capabilities, or access to system information that should be restricted.
>
> I haven't had a chance to review your patches yet, but thank you for
> posting them and responding to the early feedback.  It may take me a
> few weeks to review these patches, but they are in my review queue.
>
> -Paul
>
> --
> paul moore
> www.paul-moore.com
