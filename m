Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41Cw6AF025120
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 08:58:06 -0400
Message-ID: <536244D1.70102@tresys.com>
Date: Thu, 1 May 2014 08:57:53 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <535FBE4F.7020501@tresys.com>
 <1398947912.19535.7.camel@x220.localdomain>
In-Reply-To: <1398947912.19535.7.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/01/2014 08:38 AM, Dominick Grift wrote:
> On Tue, 2014-04-29 at 10:59 -0400, Steve Lawrence wrote:
> 
> I have not yet had time to try this out but i think i may have found
> another bug in secilc.
> 
> dontaudit rules are not included in the policy it seems.
> 
> Today i called a terms_dontaudit_use_console()
> 
> which basically has a rule like:
> 
> (dontaudit ARG1 console_device_t rw_term_perms)
> 
> But the rule is not ending up in the resulting policy (in no dontaudit
> rules at all)
> 
> secilc is looking mighty good overall though.
> 

I've tested with the pp to CIL method, Jim's cilpolicy.git, and a very
bare bones cil policy in test/policy.cil and I cannot reproduce the
issue you describe where dontaudit rules don't end up in the policy. The
only thing I can think of is that you're giving the -D flag, which will
disable dontaudits. If that's not the case, would it be possible to
provide us your CIL files?

Thanks,
- Steve
