Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71LBTnO030790
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 17:11:29 -0400
Received: from web36612.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71LBRpI028293
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 21:11:28 GMT
Date: Wed, 1 Aug 2007 14:11:27 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 4/7] Security: Add secctx_to_secid LSM hooks and security helper functions
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985323640-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <666641.25795.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> The existing LSM interface provides a hook for converting a security
> identifier
> to a security context. This patch introduces a complementary hook to provide
> the conversion from the security context to corresponding security
> identifier.

This is strictly SELinux behavior. I don't suppose it hurts
anything, but a general framework won't need this.

> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> 

...


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
