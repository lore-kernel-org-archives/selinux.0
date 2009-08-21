Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7L3cHjB014441
	for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2009 23:38:17 -0400
Received: from smtp103.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7L3bj9O022991
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 03:37:45 GMT
Message-ID: <4A8E169E.70009@schaufler-ca.com>
Date: Thu, 20 Aug 2009 20:38:06 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: jmorris@namei.org, sds@tycho.nsa.gov, gregkh@suse.de,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov> <1250774285.2542.72.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1250774285.2542.72.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> Since Casey has withdrawn his NAK for the patch I guess the only other
> concern was about the generality of the solution from Eric. Did Steve's
> response adequately address this or are there any other questions that
> people need answered before Greg can take the patch.
>   

Well, I've withdrawn the NAK, but I would still like to see:

Use the xattr, not a secid. Really. An LSM that has multiple attributes
is going to get bitten by that one. Also, any LSM that does neither
networking nor audit has no need for secids, so I would be happier if
the use of secids didn't expand into the file system space. Plus,
if it is going to be rare for an xattr to be set in sysfs (Stephen's
claim, which is consistent with my experience) saving a real xattr
should be no big deal.

Replace the security_xattr_to_secid hook in any case. All this is doing
is exposing what should be a strictly LSM internal function. You can
do it with a combination of existing hooks, if you have the time to code
up the error conditions.

You can ignore these objections if you feel you must. I'll still buy
a round in Portland.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
