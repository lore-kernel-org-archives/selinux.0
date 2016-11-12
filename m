Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uACBwv5c020842
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 06:58:57 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so21767790wmf.1
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 03:58:53 -0800 (PST)
Received: from ?IPv6:2a02:8428:4da:9800:6062:ffbf:4c1c:db04?
 (2a02-8428-04da-9800-6062-ffbf-4c1c-db04.rev.sfr.net.
 [2a02:8428:4da:9800:6062:ffbf:4c1c:db04])
 by smtp.googlemail.com with ESMTPSA id l2sm16674747wjy.39.2016.11.12.03.58.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Nov 2016 03:58:50 -0800 (PST)
Subject: Re: MLS is disabled, but MLS context "s0" found
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <401f0398-226c-7059-8c5c-8ff5b5ba632a@m4x.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <c0557f08-5281-9296-8e1e-c806eab04bbe@m4x.org>
Date: Sat, 12 Nov 2016 12:58:49 +0100
MIME-Version: 1.0
In-Reply-To: <401f0398-226c-7059-8c5c-8ff5b5ba632a@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/11/16 11:41, Nicolas Iooss wrote:
> Hello,
> 
> When using semanage from policycoreutils 2.6 I get the following error
> every time I update something (modifying a boolean, adding a user login...):
> 
>   # semanage boolean --modify --on global_ssp
>   libsepol.context_from_record: MLS is disabled, but MLS context "s0"
>   found
>   libsepol.context_from_record: could not create context structure
>   (Invalid argument).
> 
> In the code is quite clear on the reason of this warning [1]: I have
> some policy files which define file contexts with MLS context s0 even
> though I am using a non-MLS policy.
> 
> At first I thought it was an issue in the way refpolicy is being build
> (the policy I am using comes from refpolicy), but the hll files in
> /var/lib/selinux do not define s0 in the file contexts (I verified this
> using "bzcat < hll |cat -v", which showed the fc definitions).
> 
> Then I ran the hll/pp program on hll and saw that the CIL filecon
> statements use "(systemlow systemlow)", and that the base module contains:
> 
>   (sensitivity s0)
>   (sensitivityorder (s0))
>   (level systemlow (s0))
>   (mls false)
> 
> I also found a comment in module_to_cil.c describing why this is
> necessary: "CIL requires that all contexts have a range" [2].
> 
> In short, context_from_record() does not like when a file context
> defines a sensitivity level in a non-MLS policy and the current
> pp-to-cil compiler generates file contexts with sensitivity levels, in a
> non-MLS policy. Is this a bug in libsepol or something I misconfigured
> on my system?

After sending this email I found commit 4cf9b9ce2df0 ("libsemanage:
genhomedircon: only set MLS level if MLS is enabled") and I took it in
the libsemanage package I use on my system. This fixed the issue I had,
and in fact I missed the genhomedircon step in my analysis.

Problem solved. Sorry for the noise!

Nicolas
