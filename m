Date: Wed, 5 Mar 2008 11:31:14 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
cc: Chris Wright <chrisw@sous-sol.org>, sds@tycho.nsa.gov,
        casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
 security context information.
In-Reply-To: <1204675140.14520.145.camel@moss-terrapins.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0803051128210.31894@us.intercode.com.au>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
 <20080304232608.GD4416@sequoia.sous-sol.org>
 <1204672026.14520.133.camel@moss-terrapins.epoch.ncsc.mil>
 <20080304235225.GE4416@sequoia.sous-sol.org>
 <1204673709.14520.141.camel@moss-terrapins.epoch.ncsc.mil>
 <20080305001013.GF4416@sequoia.sous-sol.org> <1204675140.14520.145.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Mar 2008, Dave Quigley wrote:

> > Mainly capturing that it's doing this to a file not another object.
> 
> I can prefix it with inode so it would be inode_setsecctx and
> inode_getsecctx.

'file' might be better, as we may want similar APIs soon for sockets and 
possibly other objects which may or may not have inodes, but different 
semantics.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
