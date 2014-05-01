Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41DOQpa028135
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 09:24:34 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so1107143eek.26
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 06:24:34 -0700 (PDT)
Message-ID: <1398950672.19535.12.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 01 May 2014 15:24:32 +0200
In-Reply-To: <536244D1.70102@tresys.com>
References: <535FBE4F.7020501@tresys.com>
 <1398947912.19535.7.camel@x220.localdomain> <536244D1.70102@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-05-01 at 08:57 -0400, Steve Lawrence wrote:

> 
> I've tested with the pp to CIL method, Jim's cilpolicy.git, and a very
> bare bones cil policy in test/policy.cil and I cannot reproduce the
> issue you describe where dontaudit rules don't end up in the policy. The
> only thing I can think of is that you're giving the -D flag, which will
> disable dontaudits. If that's not the case, would it be possible to
> provide us your CIL files?

Sure, I can give the whole thing:

Here is the spec i use to build a secilc package:

https://github.com/doverride/secilc-spec

Here is my "work in progress" policy written in CIL:

https://github.com/doverride/monogam

( it has a script in "support/" that i most of the time use to
"build/load" policy )

Here is the spec i use to build a "monogam" policy package:

https://github.com/doverride/monogam-spec

Side note:

I am also using a custom installation of policycoreutils (without
semanage/semodule

The spec for that is here:

https://github.com/doverride/policycoreutils-spec

If you look in systemd policy module ( i believe ) then youll see that i
call the term_dontaudit_use_console() which for some reason does not
make it to the policy

seinfo shows no dontaudit rules and neither does sesearch
