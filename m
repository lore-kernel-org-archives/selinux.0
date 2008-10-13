Date: Tue, 14 Oct 2008 10:31:50 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [RFC v3] Security Label Support for NFSv4
In-Reply-To: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0810141014580.26030@tundra.namei.org>
References: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Sep 2008, David P. Quigley wrote:

> 	* New security flavor (auth_seclabel) to transport process label to
> 	  server. This is a derivative of auth_unix so it does not support
> 	  kerberos which has its own issues that need to be dealt with.

This is a problem, as discussed last year:

http://linux-nfs.org/pipermail/labeled-nfs/2007-November/000110.html

We can't require the use of a new auth flavor which is incompatible with 
auth_gss.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
