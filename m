Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25IOpQw006594
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 13:24:52 -0500
Received: from web36608.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m25IOoUA000045
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 18:24:51 GMT
Date: Wed, 5 Mar 2008 09:24:36 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM security context information.
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
In-Reply-To: <1204726080.1397.16.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <804501.84545.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> ...
> IIRC, originally audit directly called inode_getsecurity() to get the
> string label, and there was a (since removed) LSM hook to get the name
> suffix that it needed to pass in as input.  That was then replaced by
> use of interfaces to get the secid at audit collection time and convert
> that into a context only upon audit record generation to avoid the
> overhead associated with collecting a context always.
> 
> Whereas I think NFS just wants the context always, and it doesn't serve
> any purpose to first get a secid and then later turn it into a context.

It turns out that I agree that hooks to get the secctx of things
would be good to have, in fact I much prefer them to the secid
interfaces. I would personally prefer to see audit use them instead
of the secid interfaces, but I acknowlege the performance implications
that would have on SELinux.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
