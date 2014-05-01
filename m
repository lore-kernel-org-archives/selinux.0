Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41CcZ0a023688
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 08:38:35 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so2234741eek.20
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 05:38:34 -0700 (PDT)
Message-ID: <1398947912.19535.7.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 01 May 2014 14:38:32 +0200
In-Reply-To: <535FBE4F.7020501@tresys.com>
References: <535FBE4F.7020501@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-29 at 10:59 -0400, Steve Lawrence wrote:

I have not yet had time to try this out but i think i may have found
another bug in secilc.

dontaudit rules are not included in the policy it seems.

Today i called a terms_dontaudit_use_console()

which basically has a rule like:

(dontaudit ARG1 console_device_t rw_term_perms)

But the rule is not ending up in the resulting policy (in no dontaudit
rules at all)

secilc is looking mighty good overall though.
