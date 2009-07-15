Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org
Cc: sds@tycho.nsa.gov, gregkh@susa.de, casey@schaufler-ca.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 15 Jul 2009 10:28:55 -0400
Message-Id: <1247668135.4398.387.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For some odd reason guilt and git-send-email doesn't allow me to specify
a summary email for when there is a single patch in the patch set. So I
will put the comments here.

This is revision two of the sysfs security xattr support patch. It has
taken Eric's suggestion and adds a new structure which holds all the
optional sysfs_dirent inode metadata. This is allocated when either the
security label or some other inode property is changed. I still believe
that a secid is the way to go here and that the hooks proposed for sysfs
are usable by other psudo file systems and where to store the secid will
have to be assessed on a case by case basis.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
