From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-nfs@vger.kernel.org
Subject: Labeled-NFS: Security Label support in NFSv4  
Date: Wed,  7 Jul 2010 10:31:16 -0400
Message-Id: <1278513086-23964-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am reposting this patch set as Bruce suggested since it seems the last time
that I posted it was in the middle of a bake-a-thon. I have already received
comments from Serge and Casey for some of the LSM related patches. I would
greatly appreciate if some of the FS and NFS people could look into the rest of
them.When reviewing the code please be critical of it. If you want a tree with
the patches already applied we have posted a public git tree that is ready for
cloning and use. This tree can be found at http://git.selinuxproject.org/git
and can be cloned with the command below. You can also find information on how
to setup a labeled nfs mount at http://www.selinuxproject.org/page/Labeled_NFS
however the putclientlabel mount option specified in the setup document is no
longer supported.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
