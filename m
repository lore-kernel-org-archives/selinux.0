Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HDZIa2001098
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 09:35:18 -0400
Received: from mail-yi0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7HDZHU6021617
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 13:35:17 GMT
Received: by yia13 with SMTP id 13so926917yia.12
        for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 06:35:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E4B4CF8.6080800@schaufler-ca.com>
References: <4E4B4CF8.6080800@schaufler-ca.com>
Date: Wed, 17 Aug 2011 09:35:12 -0400
Message-ID: <CACLa4psgw+FzdJb_TUZdCmakeFrQMOVaFynsPYEe_93RHQCSrw@mail.gmail.com>
Subject: Re: inclusion of selinux.h in cred.h
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 17, 2011 at 1:09 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Is there some reason that linux/selinux.h is
> #included in linux/cred.h?
>
> I've been building kernels with the inclusion
> commented out and I have encountered no problems.
>
> It's not a problem, but I am curious.

It can be safely moved, but not removed.  This was added when
creds_are_invalid() was implemented in the header, which makes SELinux
specific calls (see commit ed868a56988464cd31de0302426a5e94d3127f10).
This function was moved to kernel/cred.c in commit
74908a0009eb36054190ab80deb9671014efed96 but the header was not moved
with it.  If you want to send a patch to move the header from cred.h
to cred.c I think that would make a lot of sense.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
