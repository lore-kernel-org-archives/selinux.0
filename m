Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HJr1rT005079
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 15:53:01 -0400 (EDT)
Message-ID: <414B4091.5030500@redhat.com>
Date: Fri, 17 Sep 2004 15:52:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Strange Associate bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I mount an NFS filesystem and then try to move a file to it,
I get permission denied and end up with an associate error

 >mount remote:/vol/vol1/home /mnt/dwalsh
 >touch /home/dwalsh/foo
 >mv /home/dwalsh/foo /mnt/dwalsh
mv: cannot create regular file `./foo': Permission denied
Sep 17 15:48:19 celtics kernel: audit(1095450499.359:0): avc:  denied  { 
associate } for  pid=19797 exe=/bin/mv name=foo 
scontext=user_u:object_r:user_home_t tcontext=system_u:object_r:nfs_t 
tclass=filesystem

allow user_home_t nfs_t:filesystem { associate };

Do I need to change mv to be able to handle this or do we need

allow domain nfs_t:filesystem associate;

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
