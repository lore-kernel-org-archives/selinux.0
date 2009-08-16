Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7GHR5j0023678
	for <selinux@tycho.nsa.gov>; Sun, 16 Aug 2009 13:27:05 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7GHS9bQ010153
	for <selinux@tycho.nsa.gov>; Sun, 16 Aug 2009 17:28:09 GMT
Message-ID: <4A8840F3.5040203@schaufler-ca.com>
Date: Sun, 16 Aug 2009 10:25:07 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>, gregkh@suse.de,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	<4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>	<4A861291.1030404@schaufler-ca.com> <m1tz09j00q.fsf@fess.ebiederm.org>	<4A864008.50907@schaufler-ca.com> <m1my61sjie.fsf@fess.ebiederm.org>
In-Reply-To: <m1my61sjie.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric W. Biederman wrote:
>
> If it is a valid optimization to inter atoms as the labels and just
> hold a couple.  I think the implementation is roughly comparable in
> size/complexity with what you have now, and likely to be a nicer in
> the common case for the people who want to do play with labels and
> sysfs.
>   

I have a notion for a different approach that might make everyone
happier. It may take a few days.

working ...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
