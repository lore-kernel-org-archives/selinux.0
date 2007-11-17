Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAH0YAbI017758
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 19:34:10 -0500
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAH0Y9hP019073
	for <selinux@tycho.nsa.gov>; Sat, 17 Nov 2007 00:34:09 GMT
Date: Fri, 16 Nov 2007 16:34:08 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 03/13] Security: Add hook to get full security xattr name
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243620.20981.9.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <781842.64970.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> When a caller wishes to get pull the extended attribute name for the security
> module for use they normally concatinate the security namespace segment and
> the
> suffix provided by the lsm. This hook provides a mechanism to obtain the full
> LSM xattr name. The patch also provides implementations for the dummy
> security
> module and SELinux.

What is the problem with the concatination scheme currently in
use? I'm not going to defend it, but why change it?

> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
> ---
>  include/linux/security.h |    7 +++++++
>  security/dummy.c         |    6 ++++++
>  security/security.c      |    6 ++++++
>  security/selinux/hooks.c |    6 ++++++
>  4 files changed, 25 insertions(+), 0 deletions(-)

Please cross post proposed LSM changes to the LSM mailing list.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
