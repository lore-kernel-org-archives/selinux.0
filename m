From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Subject: Labeled-NFS: Security Label support in NFSv4 
Date: Tue,  8 Jun 2010 12:22:46 -0400
Message-Id: <1276014176-20315-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It has been quite a while since the last time we submitted a patch set to the
mailing list for review. I met with Trond at the last IETF meeting and he
suggested that we resubmit the patches for review since the IETF process has
moved along since the last posting. When reviewing the code please be critical
of it. If you want a tree with the patches already applied we have posted a
public git tree that is ready for cloning and use. This tree can be found at
http://git.selinuxproject.org/git and can be cloned with the command below. You
can also find information on how to setup a labeled nfs mount at
http://www.selinuxproject.org/page/Labeled_NFS however the putclientlabel mount
option specified in the setup document is no longer supported.

git-clone git://git.selinuxproject.org/~dpquigl/lnfs.git



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
