Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3NMRv8d015429
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 18:28:02 -0400
Received: by oblw8 with SMTP id w8so25035375obl.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 15:28:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1428616130-14570-1-git-send-email-jeffv@google.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
Date: Thu, 23 Apr 2015 18:28:00 -0400
Message-ID: <CAHC9VhQK8aO-1oP+XxC19ytP_ZFdCnkX=_x87YpEAdxGEtTTzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 9, 2015 at 5:48 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
> ---- motivation ----
> Ioctls provide many of the operations necessary for device control. The typical
> driver supports a device specific set of operations accessible by the ioctl
> system call and specified by the command argument. SELinux provides per
> operation access control to many system operations e.g. chown, kill, setuid,
> ipc_lock, etc. Ioclts on the other hand are granted on a per file descriptor
> basis using the ioctl permission, meaning that the set of operations provided
> by the driver are granted on an all-or-nothing basis. In some cases this may be
> acceptable, but often the same driver provides a large and diverse set of
> operations such as benign and necessary functionality as well as dangerous
> capabilities, or access to system information that should be restricted.

I haven't had a chance to review your patches yet, but thank you for
posting them and responding to the early feedback.  It may take me a
few weeks to review these patches, but they are in my review queue.

-Paul

-- 
paul moore
www.paul-moore.com
