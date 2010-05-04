From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1 1/6] selinux: Update socket's label alongside inode's label
Date: Tue, 4 May 2010 11:29:05 -0400
Cc: selinux@tycho.nsa.gov
References: <20100503220455.8177.91177.stgit@flek.lan> <20100503221122.8177.80352.stgit@flek.lan> <1272978238.30175.22.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1272978238.30175.22.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005041129.06051.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 09:03:53 am Stephen Smalley wrote:
> On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> > We have always had a potential disconnect between the label on socket and
> > the label on the associated inode when a user calls fsetxattr() on a
> > socket.  The problem is that the fsetxattr() call would only relabel the
> > inode and not the corresponding socket; the good news is that the
> > mainstream SELinux policies have always prevented this, but better safe
> > than sorry ...
> > 
> > This patch fixes this problem by adding the necessary socket labeling
> > code to selinux_inode_setsecurity() so that if a user did relabel a
> > socket via fsetxattr() both the inode and socket would be relabeled.
> > 
> > Signed-off-by: XXX
> > ---
> > 
> >  security/selinux/hooks.c            |   39
> >  ++++++++++++++++++++++++++++++++++- security/selinux/include/netlabel.h
> >  |    5 ++--
> >  security/selinux/netlabel.c         |    8 +++++--
> >  3 files changed, 46 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5feecb4..f9545c8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2920,6 +2920,43 @@ static int selinux_inode_setsecurity(struct inode
> > *inode, const char *name,
> > 
> >  	if (rc)
> >  	
> >  		return rc;
> > 
> > +	if (S_ISSOCK(inode->i_mode)) {
> 
> I think this is the wrong test - it would evaluate to true for both the
> socket inode and for the file inode by which the socket is named, which
> are separate and distinct objects.  I think you want:
> 	if (inode->i_sb->s_magic == SOCKFS_MAGIC)
> which would only be true for the actual socket inode.

Thanks for the review ...

Sounds reasonable, I wasn't sure this was 100% right but it seemed like a 
reasonable place to start.  I haven't had a chance to test this yet as I need 
to write a little dummy app that does a fsetxattr() on a socket - amazing that 
apps like this don't exist ;)


> > +		lock_sock(sk);
> > +		sksec->sid = newsid;
> > +		selinux_netlbl_sk_security_reset(sksec);
> > +		rc = selinux_netlbl_socket_setsid(sk, sk->sk_family);
> > +		release_sock(sk);
> > +		if (rc)
> > +			return rc;
> 
> If the netlabel state change fails, do we want to revert the sksec->sid
> to its original value?

Funny you mention this, I was going over the patches again this morning and 
noticed this; I also moved the SID assignments outside of the socket lock, 
probably not a big deal, but you never know ... Regardless, I've already made 
the changes and they will be in the next version.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
