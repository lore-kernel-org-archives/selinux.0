Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HK8orT005250
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 16:08:50 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HK7rNM014111
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 20:07:54 GMT
Subject: Re: Strange Associate bug
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <414B4091.5030500@redhat.com>
References: <414B4091.5030500@redhat.com>
Content-Type: text/plain
Message-Id: <1095451597.17932.332.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 16:06:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-17 at 15:52, Daniel J Walsh wrote:
> If I mount an NFS filesystem and then try to move a file to it,
> I get permission denied and end up with an associate error
> 
>  >mount remote:/vol/vol1/home /mnt/dwalsh
>  >touch /home/dwalsh/foo
>  >mv /home/dwalsh/foo /mnt/dwalsh
> mv: cannot create regular file `./foo': Permission denied
> Sep 17 15:48:19 celtics kernel: audit(1095450499.359:0): avc:  denied  { 
> associate } for  pid=19797 exe=/bin/mv name=foo 
> scontext=user_u:object_r:user_home_t tcontext=system_u:object_r:nfs_t 
> tclass=filesystem
> 
> allow user_home_t nfs_t:filesystem { associate };
> 
> Do I need to change mv to be able to handle this or do we need
> 
> allow domain nfs_t:filesystem associate;

You mean:
allow file_type nfs_t:filesystem associate;

Options are:
1) Change the kernel code to ignore the fscreate context when the
filesystem uses genfs_contexts, similar to the existing mount context=
handling, or
2) Change mv to reset the fscreate context to NULL and retry if the file
creation fails with EACCES, thereby falling back to the default labeling
behavior,
3) Allow the association, as above.

Allowing the association is a bit misleading, because the file is going
to revert to the base type ultimately, even if the incore inode happens
to be temporarily labeled with the fscreate context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
