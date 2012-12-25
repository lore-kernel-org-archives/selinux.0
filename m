Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBP4eMIu031984
	for <selinux@tycho.nsa.gov>; Mon, 24 Dec 2012 23:40:22 -0500
Message-ID: <50D92E0F.2050909@davequigley.com>
Date: Mon, 24 Dec 2012 23:39:43 -0500
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: joseph_vu@hotmail.com, steved@redhat.com, trond.myklebust@netapp.com,
        bfields@fieldses.org, rodel_fm@dsi.a-star.edu.sg,
        casey@schaufler-ca.com
CC: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: Labeled NFS Meeting Info for Tonight Dec 20/Dec 21st for our
 friends in Singapore
References: <cd02d79979bf6c825152f3bcf3a7f33d@countercultured.net>
In-Reply-To: <cd02d79979bf6c825152f3bcf3a7f33d@countercultured.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The notes below summarize what we decided during out last meeting. It 
also has our next meeting date. There are some more issues that need to 
be fixes


Shooting for merge window 3.9.

List of things to do:

Add warning fixup patch into tree (Dave Q)
Patch to cleanup comment for dentry_init_security (Dave Q)
Patch to cleanup comment to reflect that xattrs aren’t being used in the 
protocol (ismaclabel lsm hook) (Dave Q)

Patch to remove export option (SteveD)
Patch to fix ifdefs in client (SteveD)
Patch to fix ifdefs in server (SteveD)
Patch to remove bugons (Dave)

Rodel:

Work on making our attribute encoding/decoding work more like 
encode/decode_fsinfo. This means removing the extend fattr to use 3rd 
word patch and instead placing the information inside an op specific struct.
Work on Attribute change notification:
Smaller patches if possible (client, server, support, etc...)

Leaving RPCSECGSSv3 for now.

January 10th next Meeting.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
