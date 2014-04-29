Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3TMIISn002934
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 18:18:18 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so754236eei.19
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 15:18:17 -0700 (PDT)
Message-ID: <1398809895.25918.15.camel@x220.localdomain>
Subject: Re: selinux_check_access() and unknown classes/perms
From: Dominick Grift <dominick.grift@gmail.com>
To: Eric Paris <eparis@parisplace.org>
Date: Wed, 30 Apr 2014 00:18:15 +0200
In-Reply-To: <CACLa4pvP9mjjGvQ+SkyoorYZAAdxAHMy3maK8rmkbJRMa6JQPA@mail.gmail.com>
References: <CACLa4pvP9mjjGvQ+SkyoorYZAAdxAHMy3maK8rmkbJRMa6JQPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-29 at 17:14 -0400, Eric Paris wrote:
> selinux_check_access() has code like this:
> 
>        sclass = string_to_security_class(class);
>        if (sclass == 0) {
>                rc = errno;
>                if (security_deny_unknown() == 0)
>                        return 0;
>                errno = rc;
>                return -1;
>        }
> 
> My problem with the code is that we have no logging of any kind why we
> just returned -1;  The reason this was found is because Dominick is
> writing custom policy that doesn't define all of the classes/perms
> used by systemd and has security_deny_unknown() == 1.  systemd calls
> selinux_check_access() gets -EINVAL, prints that it denied, but no
> where do we have a good reason why it was denied.  systemd doesn't
> know, it's hidden in this library...

Systemd just prints: SELinux policy denies access. That is it. There is
no way to tell that there are unknown permissions and which unknown
permissions. One ends up in a situation that is not easy to debug.

In my case i knew directly this was about the systemd permissions
associated with the system kernel security class. I was hesitant to add
those since to me it just does not sound right to associate user space
permissions with a kernel security class.

This issue surfaced as part of a bigger issue that i identified where at
some point late in the shutdown process no avc's are logged at all
anymore. Whether it be user space avc denials or kernel avc denials.

For example if systemd would not have permissions to unmount file
systems then attempts my systemd to unmount file systems on shutdown
would be denied without any logs.

As a policy writer, avc denials and other SELinux messages is all i have
to go with. If SELinux blocks without any information then i do not know
what to do.
