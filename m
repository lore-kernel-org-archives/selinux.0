Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3O4CZgw001617
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 00:12:36 -0400
From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: Paul Moore <paul@paul-moore.com>
Subject: RE: Switching to enforcing mode introduces new policy issues?
Date: Fri, 24 Apr 2015 04:12:25 +0000
Message-ID: <d15a5dc7a1fc4677b6ea3908b7480c6c@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <CAHC9VhS33Jys15zLsyy+RCLpgkAu4m-r-O5LY=Bstt7YJc8sWA@mail.gmail.com>
In-Reply-To: <CAHC9VhS33Jys15zLsyy+RCLpgkAu4m-r-O5LY=Bstt7YJc8sWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "SELinux \(selinux@tycho.nsa.gov\)" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That sounds like an idea, I'll have to give it a shot. To add a bit more information, I'm seeing a bunch of these changes happen during the boot process in init and I would assume the AVC is cleared between reboots - I've tweaked and added some things there for experimentation. I can boot my system up in permissive and see no problems, but when I restart it in enforcing I start seeing brand new policy violations, things I haven't seen before. It seems odd that the same boot sequence would result in such different behavior.

-Aaron

-----Original Message-----
From: Paul Moore [mailto:paul@paul-moore.com] 
Sent: Thursday, April 23, 2015 5:20 PM
To: Spector, Aaron
Cc: SELinux (selinux@tycho.nsa.gov)
Subject: Re: Switching to enforcing mode introduces new policy issues?

On Thu, Apr 23, 2015 at 5:14 PM, Spector, Aaron <Aaron_Spector@mcafee.com> wrote:
> Hi all,
>
> I’ve been working on writing my first policy for SELinux and I’ve hit 
> a bit of a snag. I’ve gotten the policy clean in permissive mode, but 
> when I swap the system over to enforcing, a whole new set of policy issues crop up.
> Everything I’ve read says this isn’t to be expected so I’m a bit 
> confused as to what’s happening.

{snip}

> So far what I’ve had to do to get around it is to add to my policy, 
> but that doesn’t seem like that should be necessary. If the audit is 
> clean in permissive mode, why isn’t it clean in enforcing?
>
> Is it possible that I’m missing policy deny audits when it’s in 
> permissive mode?

It's important to remember that when you are in permissive mode you will only see a given SELinux AVC denial *once*, after that it will not be reported until the AVC is reset.  My two favorite ways of resetting the SELinux AVC are to run either 'load_policy' or toggle the system from permissive into enforcing and then back into permissive mode.  Try that and I suspect that will solve your problem.

-Paul

--
paul moore
www.paul-moore.com
