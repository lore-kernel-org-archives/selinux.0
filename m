Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBBJtEkw005009
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 14:55:22 -0500
Received: by qkdp187 with SMTP id p187so54952520qkd.1
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 11:55:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <566B17FB.6010405@android.com>
References: <566B17FB.6010405@android.com>
Date: Fri, 11 Dec 2015 14:55:10 -0500
Message-ID: <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: Paul Moore <paul@paul-moore.com>
To: Daniel Cashman <dcashman@android.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 nnk@google.com, arve@google.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 11, 2015 at 1:37 PM, Daniel Cashman <dcashman@android.com> wrote:
> Hello,
>
> I would like to write a patch that would expose, via selinuxfs, the
> mapping between secids in the kernel and security contexts to
> user-space, but before doing so wanted to get some feedback as to
> whether or not such an endeavor could have any support upstream.  The
> direct motivation for this is the desire to communicate calling security
> ids/contexts over binder IPC on android for use in a user-space object
> manager.  Passing the security ids themselves would be simpler and more
> efficient in the critical kernel path, but they currently have no
> user-space meaning.

In general we try to avoid exposing the secid tokens outside the
kernel, I view them as an implementation hack designed to make it
easier to manage and operate on the security labels in the kernel.  I
suspect you will hear something very similar from Casey and the other
Smack developers.  Another consideration is the long standing LSM
stacking effort, they have several good reasons for wanting to abolish
the secid token, propagating it to userspace would make that all but
impossible.

While I'm sympathetic to your desire for less complexity and better
performance in passing security labels, from a kernel perspective I
think we lose too much in exporting the secid tokens outside the LSM.

-- 
paul moore
www.paul-moore.com
