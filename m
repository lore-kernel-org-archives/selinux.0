Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JLsKCD016854
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 17:54:20 -0400
Received: by obcxo2 with SMTP id xo2so65163161obc.0
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 14:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
Date: Thu, 19 Mar 2015 17:54:18 -0400
Message-ID: <CAGNxgPj8Bqa8xHJ7=YFEC_5WXv290T_+OtgL4zgrL5SxLGgW8g@mail.gmail.com>
Subject: Re: Trying to update sysadm module in CLIP
From: Spencer Shimko <spencer@quarksecurity.com>
To: John Chludzinski <john.chludzinski@vivaldi.net>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It is hard to tell at first glance but these questions are
CLIP-specific.  Thus, these questions are best suited for the CLIP
mailing list:
http://oss.tresys.com/mailman/listinfo/clip

But my responses are in-line below.

On Thu, Mar 19, 2015 at 4:31 PM, John Chludzinski
<john.chludzinski@vivaldi.net> wrote:
> First thing ... I'm a newbie to SELinux.
>
> I'm trying to update the sysadm module in a CLIP image. I downloaded the
> SELinux policy code from: https://github.com/QuarkSecurity/CLIP.  I modified
> the sysadm policy code and built (in
> ~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:
>
> $ make modules APPS_MODS="sysadm"
>
> Then I tried to install in the CLIP image using:
>
> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
>
> and got: "tried to link in a non-MLS module with an MLS base". (I assume
> this means the CLIP image I'm working with is MLS?)
> Next I built using:
>
> $ make modules APPS_MODS="sysadm" TYPE="mls"
>

The CLIP default is MCS but it also builds MLS policies.

> Tried to load/install the module and got: "sensitivy s10 not declared by
> base."
>
> Next I tried:
>
> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls" MLS_SENS=15
>
> and !still! got "sensitivy s10 not declared by base".
>
> Any suggestions/thoughts?

I'm not sure exactly which version of our repo you're using and things
might have changed a bit but but I think these steps will work for
you.

You are building policy without actually rolling it up in an RPM.
Much like Red Hat's spec file which CLIP's is based on, the RPM spec
file in CLIP does a lot of configuration work via command-line
arguments to make etc.  The spec file is
"packages/clip-selinux-policu/clip-selinux-policy.spec".

As building a policy outside of an RPM will cause unkonwn changes in
the policy tree, you might want to reset the tree and rebuild via an
RPM.  If you want to enable a module you can do it in:
packages/clip-selinux-policy/clip-selinux-policy/policy/modules.conf.

Alternatively, CLIP has support for enabling modules via tthe
ENABLE_MODULES variable in "packages/clip-selinux-policy/Makefile"

You have two choices here.  The first, and highly recommeended way, is
using mock.  Go to the top-levedl of the CLIP tree and run "make
clip-selinux-policy-rpm".  The resulting policy RPMs can be found in
repos/clip-repo/clip-selinux-policy*.rpm.

Or you can build outside of mock by going into
packages/clipselinux-policy and running "make rpm".  The RPMs will end
up in your current directory, packages/clip-selinux-policu/*.rpm.

Thanks,
--Spencer

Spencer Shimko
Quark Security, Inc
quarksecurity.com

>
> ---John
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
