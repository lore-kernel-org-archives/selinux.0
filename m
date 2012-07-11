Message-ID: <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid and policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 08:50:45 -0400
In-Reply-To: <4FFCC3C7.8080602@tresys.com>
References: <4FFCC3C7.8080602@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 20:07 -0400, Joshua Brindle wrote:
> I was looking at this:
> <https://android-review.googlesource.com/#/c/36321/4/init/init.c>
> 
> and remembered that years ago we had a discussion about the .policyver 
> filename syntax. I kind of get it for SELinux machines where there is 
> managed policy and could be multiple policies on the system but since 
> SEAndroid is targeting non-device managed policies, it adds extra code 
> to search for the right extension and you can tell what version the 
> policy is as soon as you open it, why not ditch the suffix?

First, that patch doesn't introduce the use of the version suffix
(that's in the already merged code); it just preserves it in the new
logic for reloading policy at runtime.

I'm open to removing the use of the policy version suffix in a follow-on
patch, although that would need to be coordinated across sepolicy and
system/core.  But the current code is consistent with existing practice
in Linux distributions (so follows principle of least surprise) and it
allows for different versions to be installed simultaneously (thereby
supporting booting multiple kernels).  Also, we don't have libsepol on
the device so we cannot in fact determine the version when we open it
there presently.  So I'm not convinced we should remove the suffix.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
