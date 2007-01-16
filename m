Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GKV7of023526
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 15:31:07 -0500
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0GKVwAN017797
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 20:31:59 GMT
Date: Tue, 16 Jan 2007 12:31:58 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: FW: Current/Future Plans to Support Stacking LSM Modules
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Tom Fortmann <tfortmann@xcapesolutions.net>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <251786.34008.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> If you are adding additional security at the
> application data layer,
> then you can do that in userspace, and use SELinux
> Type Enforcement to
> make it unbypassable and tamperproof.  You don't
> need to change the
> kernel.

Stephen, you can't possibly know that kernel
changes aren't required from the information
provided. The information provided appears
to be intentionally imprecise. (not a good
idea in the community, BTW) You may prove
correct in the end (you often are) but you're
jumping the SELinux Uber Alas gun.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
