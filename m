From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: move security_skb_extlbl_sid() out of the security server
Date: Thu, 1 Mar 2007 14:35:08 -0500
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
References: <20070301173459.128882191@hp.com> <1172774649.19041.582.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172774649.19041.582.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703011435.08537.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, March 1 2007 1:44:09 pm Stephen Smalley wrote:
> On Thu, 2007-03-01 at 12:34 -0500, Paul Moore wrote:
> > plain text document attachment (selinux-skbextlbl_move)
> > As suggested, move the security_skb_extlbl_sid() function out of the
> > security server and into the SELinux hooks file.
>
> Thanks, but one minor change suggested - rename the function, as
> security_ prefix in selinux means security server (which in turn is
> confusing since LSM also uses that prefix, but we had it first!).  Since
> it is static, you don't even need distinct namespace for it, so even
> skb_extlbl_sid() is fine.

Ah yes, thank you.  I did that in the previous patchset but forgot to do so 
here.  Personally I tend to like the security_/selinux_ prefix (it keeps my 
finger's busy <g>) so I'll just switch from security_ to selinux_.

Patch coming in just a second.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
