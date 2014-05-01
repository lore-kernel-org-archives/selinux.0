Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41HpQDX018420
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 13:51:26 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so2466357eei.0
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 10:51:06 -0700 (PDT)
Message-ID: <1398966664.19535.20.camel@x220.localdomain>
Subject: Re: What's a policy configuration file?
From: Dominick Grift <dominick.grift@gmail.com>
To: dE <de.techno@gmail.com>
Date: Thu, 01 May 2014 19:51:04 +0200
In-Reply-To: <53628456.8020407@gmail.com>
References: <53627C9F.9020109@gmail.com>
 <CAB9W1A1+Rh0hDW+dNzehTbo0p4r-vaGWdugks9UnfNoZ5xuinQ@mail.gmail.com>
 <53628456.8020407@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-05-01 at 22:58 +0530, dE wrote:

> http://www.nsa.gov/research/_files/selinux/papers/policy2/x109.shtml
> 
> http://selinuxproject.org/page/ConfigurationFiles#Policy_Configuration_Files
> 
> I would like to know what the official website means -- it's definitely 
> the sources. I hope I'll read about policy.conf in the NSA reference.

I suppose it can have various meanings depending on the context in which
the term is used.

Policy IS configuration, and so any file with policy in it in any format
could be referred to as "policy configuration" file

Then there are the configuration files that are distributed with the
policy configuration. I suppose technically those are "policy
configuration" configuration files.

There there is often also a configuration files that specifies the
options with which a policy configuration is compiled, and so i suppose
one could also refer to that file as a "policy configuration"
configuration file.

Welcome to the wonderful world of SELinux terminology! 
