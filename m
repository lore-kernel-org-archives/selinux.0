Subject: Re: [PATCH -v2] NFS/LSM: allow NFS to control all of its own mount
	options
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: linux-nfs@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        steved@redhat.com, jlayton@redhat.com, sds@tycho.nsa.gov,
        jmorris@namei.org, casey@schaufler-ca.com, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com, hch@infradead.org
In-Reply-To: <1204573372.3216.42.camel@localhost.localdomain>
References: <1204573372.3216.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 14:38:42 -0500
Message-Id: <1204573122.14520.90.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This patch was tested with NFSv3 mounts and solves all of the
> regressions that have been introduced in the NFS code.  It supports both
> the binary interface and text options without pushing LSM specific
> parsing into the FS.  It doesn't introduce the new LSM constructs
> necessary to show these mount options in /proc/mounts suggested by
> Miklos Szeredi but that will be coming in 2.6.26 (it's not a regression
> or bug fix).  I also do not have the proper security_sb_set_mnt_opts()
> call in nfs4_get_sb due to a lack of a testing environment, but will add
> that in 2.6.26 as well.  SELinux + NFSv4 have never had context mount
> options so there is no regression nor loss of functionality.
> 
> Would the NFS community like to push all of this through their bug fix
> trees or would they prefer I just push this whole patch up the SELinux
> trees?

I see above that the patch does not provide this support for NFSv4. Do
you intend on adding this in the future or is it being deferred to
someone else?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
