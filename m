Subject: Re: [PATCH]Introduce generalized hooks for getting and setting
	inode secctx.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@lst.de>, Casey Schaufler <casey@schaufler-ca.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <Xine.LNX.4.64.0804290104000.2081@us.intercode.com.au>
References: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <Xine.LNX.4.64.0804280932520.17090@us.intercode.com.au>
	 <20080428060620.GA9902@lst.de>
	 <Xine.LNX.4.64.0804290104000.2081@us.intercode.com.au>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 11:10:27 -0400
Message-Id: <1209395427.29937.299.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My main goal here is to get labeled-nfs in to mainline in chunks instead
of throwing massive 25+ patch sets at you later on. People are far less
likely to review patch sets when they are massive so I figured a series
of smaller chunks would attract more attention. I have no problem
working off of a labeled-nfs tree with this patches applied to it but
I'd like to avoid getting stuff reacked every time I post it.

Dave

On Tue, 2008-04-29 at 01:04 +1000, James Morris wrote:
> On Mon, 28 Apr 2008, Christoph Hellwig wrote:
> 
> > On Mon, Apr 28, 2008 at 09:33:22AM +1000, James Morris wrote:
> > > Cristoph, Casey -- any chance of getting ack or nack on this before the 
> > > merge window closes?
> > 
> > No concernes about this patch, but as usual strong objections against
> > introducing it without the actual user.
> 
> Ok, we might put them into a labeled-nfs tree rather than pushing them to 
> mainline at this stage.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
