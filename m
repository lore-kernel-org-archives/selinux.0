Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4ELFYOq008307
	for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 17:15:34 -0400
Received: by qcsk26 with SMTP id k26so4127868qcs.12
        for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 14:15:35 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Mon, 14 May 2012 17:15:32 -0400
Message-ID: <12617452.LZMSpbtozB@sifl>
In-Reply-To: <1337015850.28157.43.camel@moss-pluto>
References: <4FA95098.1050201@tresys.com> <1337015850.28157.43.camel@moss-pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 14, 2012 01:17:30 PM Stephen Smalley wrote:
> Didn't the old behavior lead to the undesirable result that refpolicy
> allows every domain (or at least every domain that does networking) to
> send/recv unlabeled packets, such that you cannot effectively employ
> SECMARK unless you first modify and rebuild your entire policy to take
> away the unlabeled packet access?  Whereas with the new behavior one
> could drop those rules and then when someone does enable SECMARK, they
> get to fully define the allowable network traffic?

Yep.
 
> I'm not adverse to making it optional/configurable, but I think a policy
> capability is how you should do it.  That is what they are for, and they
> are supposed to provide a more explicit mechanism than either the
> handle_unknown logic or the old compat_net logic ...

*If* we decide to go this route, I agree, policy capabilities seem to be the 
best fit.

However, as I said earlier in my emails to Chris, I'm still not certain this 
actually accomplishes anything useful.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
