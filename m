Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Gregory Ade <gkade@bigbrother.net>, Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: [Fwd: Re: Policy]
Date: Thu, 4 Apr 2002 04:38:52 +0200
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SeLinux@tycho.nsa.gov,
        sds@tislabs.com, pal@tycho.nsa.gov
References: <1017882461.14980.107.camel@pslgregory>
In-Reply-To: <1017882461.14980.107.camel@pslgregory>
MIME-Version: 1.0
Message-Id: <20020404023852.D35823FEA4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Apr 2002 03:06, Gregory Ade wrote:
> I'd agree with this.  if the goal is to become a seamless part of the
> underlying distribution, then stay out of /usr/local or /opt; just go
> ahead and replace the existing binaries (optionally, for the more
> advanced packagers, you could make backup copies of all the originals,
> like 'ls.preselinux' or whatever).  To be really slick, the SELinux
> packages would act as upgrades or replacements for whichever packages'
> binaries are being replaced, so that the package manager can keep track
> of everything sanely.
>
> When building from source, I'd most likely put it /usr/local/selinux,
> just to keep it simple.  In my eyes, /usr/local (and, to an extent,
> /opt) is the sole domain of the sysadmin to manage at his discretion,
> and package managers should keep their grubby fingers out of there. =)

Seems like we're getting agreement on that.

> Or, how's this for an idea (note that i'm very unfamiliar with the
> current way policies are managed, so this could well be construed as me
> talking out my behind):
>
> Policy is defined, instead of in a single file, by a combination of a
> "top" configuration file and a "bottom" directory containing parts.
> i.e.:
>
> /etc/selinux/policy	- local sysadmin-defined policy rules
>
> /etc/selinux/policy.d/*	- policy fragments installed by the various
> SELinux components

We currently have /etc/selinux/domains/programs for policy fragments for 
particular programs.

> Then, the programs that actually check and apply the policies would
> first compile them from the /etc/selinux/policy.d/* files, and then
> apply the policies from /etc/selinux/policy, where conflicts result in
> /etc/selinux/policy overriding anything else?

Conflicts should result in an error message and the administrator having to 
fix it!

For ordering, we could prepend a 2 digit number like we do for init scripts.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
