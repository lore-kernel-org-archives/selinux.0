Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86Fx69L000864
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 11:59:06 -0400
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86Fx48b011429
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 15:59:04 GMT
Date: Thu, 6 Sep 2007 08:59:03 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH] 1/2 SELinux: Add get, set, and cloning of superblock security information
To: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        nfs@lists.sourceforge.net
Cc: sds@tycho.nsa.gov, jmorris@namei.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
In-Reply-To: <1189030563.3460.41.camel@dhcp231-215.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <636439.78887.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Eric Paris <eparis@redhat.com> wrote:

> Adds security_get_sb_mnt_opts, security_set_sb_mnt_opts, and
> security_clont_sb_mnt_opts to the LSM and to SELinux.  This is in
> preparation for NFS to be able to own its own mount options and remove
> the NFS specific code from SELinux.

What is the purpose of security_clone_sb_mnt_opts? I see where it is
being used, but it's not clear to me why it is necessary. The old SELinux
code doesn't clone the options, it filters out the ones it cares about.
If that is the behavior you'd expect of this hook, I suggest the name
reflect that, perhaps security_filter_sb_mnt_opts.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
