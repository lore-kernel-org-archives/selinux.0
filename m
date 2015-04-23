Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3NMJqLY014851
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 18:19:52 -0400
Received: by oblw8 with SMTP id w8so24913147obl.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 15:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
Date: Thu, 23 Apr 2015 18:19:50 -0400
Message-ID: <CAHC9VhS33Jys15zLsyy+RCLpgkAu4m-r-O5LY=Bstt7YJc8sWA@mail.gmail.com>
Subject: Re: Switching to enforcing mode introduces new policy issues?
From: Paul Moore <paul@paul-moore.com>
To: "Spector, Aaron" <Aaron_Spector@mcafee.com>
Content-Type: text/plain; charset=UTF-8
Cc: "SELinux \(selinux@tycho.nsa.gov\)" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 23, 2015 at 5:14 PM, Spector, Aaron
<Aaron_Spector@mcafee.com> wrote:
> Hi all,
>
> I’ve been working on writing my first policy for SELinux and I’ve hit a bit
> of a snag. I’ve gotten the policy clean in permissive mode, but when I swap
> the system over to enforcing, a whole new set of policy issues crop up.
> Everything I’ve read says this isn’t to be expected so I’m a bit confused as
> to what’s happening.

{snip}

> So far what I’ve had to do to get around it is to add to my policy, but that
> doesn’t seem like that should be necessary. If the audit is clean in
> permissive mode, why isn’t it clean in enforcing?
>
> Is it possible that I’m missing policy deny audits when it’s in permissive
> mode?

It's important to remember that when you are in permissive mode you
will only see a given SELinux AVC denial *once*, after that it will
not be reported until the AVC is reset.  My two favorite ways of
resetting the SELinux AVC are to run either 'load_policy' or toggle
the system from permissive into enforcing and then back into
permissive mode.  Try that and I suspect that will solve your problem.

-Paul

-- 
paul moore
www.paul-moore.com
