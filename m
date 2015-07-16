Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GE0rGn000644
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 10:00:53 -0400
Received: by oibn4 with SMTP id n4so50797592oib.3
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:00:51 -0700 (PDT)
Date: Thu, 16 Jul 2015 08:59:47 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150716135947.GC77715@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87615k7pyu.fsf@x220.int.ebiederm.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 10:15:21PM -0500, Eric W. Biederman wrote:
> 
> Seth I think for the LSMs we should start with:
> 
> diff --git a/security/security.c b/security/security.c
> index 062f3c997fdc..5b6ece92a8e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -310,6 +310,8 @@ int security_sb_statfs(struct dentry *dentry)
>  int security_sb_mount(const char *dev_name, struct path *path,
>                         const char *type, unsigned long flags, void *data)
>  {
> +       if (current_user_ns() != &init_user_ns)
> +               return -EPERM;
>         return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
>  }

This just makes it impossible to mount from a user namespace. Every
mount from current_user_ns() != &init_user_ns will fail.

> Then we should push this down into all of the lsms.
> Then when we should remove or relax or change the check as appropriate
> in each lsm.
> 
> The point is this is good enough to see that it is trivially safe,
> and this allows us to focus on the core issues, and stop worrying about
> the lsms for a bit.
> 
> Then we can focus on each lsm one at at time and take the time to really
> understand them and talk with their maintainers etc to make certain
> we get things correct.
> 
> This should remove the need for your patches 5, 6 and 7. For the
> immediate future.

I'm still not entirely sure what you were trying to do, maybe refuse to
mount whenever a security module is loaded? I think this could be a good
option to start, but couldn't we restrict it to only the LSMs which use
xattrs for security labels? In situations where the filesystem cannot
supply security policy metadata I can't think of any reason to disallow
the mounts.

Seth
