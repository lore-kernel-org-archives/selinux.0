Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAD1e5St023679
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2012 20:40:06 -0500
Message-ID: <50A1A4EE.7030507@davequigley.com>
Date: Mon, 12 Nov 2012 20:39:58 -0500
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: Steve Dickson <SteveD@redhat.com>
CC: "J. Bruce Fields" <bfields@fieldses.org>,
        "David P. Quigley" <selinux@davequigley.com>,
        trond.myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Labeled NFS [v5]
References: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com> <20121112152335.GH30713@fieldses.org> <50A116F0.5050404@davequigley.com> <20121112160959.GK30713@fieldses.org> <50A16269.4060601@RedHat.com>
In-Reply-To: <50A16269.4060601@RedHat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you're ok with non Fedora kernel images I can try to put up a tree 
either tonight or tomorrow with the patches that you just need to build 
and install. That plus the one patch for nfs-utils should make 
everything work.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
