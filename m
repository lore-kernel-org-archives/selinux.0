Date: Mon, 19 Dec 2016 15:19:46 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: sds@tycho.nsa.gov
Cc: sgrubb@redhat.com, paul@paul-moore.com, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] selinux: log errors when loading new policy
Message-ID: <20161219151946.GA5359@workstation>
References: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
 <1482007719-14313-2-git-send-email-gary.tierney@gmx.com>
 <1482158586.28570.17.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1482158586.28570.17.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 19, 2016 at 09:43:06AM -0500, Stephen Smalley wrote:
> On Sat, 2016-12-17 at 20:48 +0000, Gary Tierney wrote:
> > Adds error and warning messages to the codepaths which can fail when
> > loading a new policy.  If a policy fails to load, an error message
> > will
> > be printed to dmesg with a description of what failed.  Previously if
> > there was an error during policy loading there would be no indication
> > that it failed.
> > 
> > Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> > ---
> >  security/selinux/selinuxfs.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/selinux/selinuxfs.c
> > b/security/selinux/selinuxfs.c
> > index 0aac402..2139cc7 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -522,20 +522,32 @@ static ssize_t sel_write_load(struct file
> > *file, const char __user *buf,
> >  		goto out;
> >  
> >  	length = security_load_policy(data, count);
> > -	if (length)
> > +	if (length) {
> > +		pr_err("SELinux: %s: failed to load policy\n",
> > +		      __func__);
> 
> Not sure about your usage of pr_err() vs pr_warn();
> security_load_policy() may simply fail due to invalid policy from
> userspace, not a kernel-internal error per se.
> 

The intention was to make a distinction between failures on or after
security_load_policy().  If security_load_policy() fails then no audit message
will be logged about loading a new policy, so it seemed more appropriate to
treat that case as KERN_ERROR.  Though with what you said in mind, it is
probably better to change this to pr_warn() as security_load_policy() is
unlikely to cause an actual kernel-internal error.

> I would tend to omit the function name; I don't think it is especially
> helpful.
> 

Agreed.  It seems to be used as a convention throughout security/selinux,
though am happy to drop it from the patch.

I was planning to send a v2 with pr_err() swapped for pr_warn() and __func__
dropped from the log message, though keeping in mind that Steve has prepared a
patch for this (also, logging to the audit subsystem might be more
appropriate) would it be better to drop #1 and keep #2?

> There was an earlier discussion about augmenting the audit logging from
> this function, so this might overlap with that.  I don't know where
> that stands.
> 
> >  		goto out;
> > +	}
> >  
> >  	length = sel_make_bools();
> > -	if (length)
> > +	if (length) {
> > +		pr_warn("SELinux: %s: failed to load policy
> > booleans\n",
> > +		       __func__);
> >  		goto out1;
> > +	}
> >  
> >  	length = sel_make_classes();
> > -	if (length)
> > +	if (length) {
> > +		pr_warn("SELinux: %s: failed to load policy
> > classes\n",
> > +		       __func__);
> >  		goto out1;
> > +	}
> >  
> >  	length = sel_make_policycap();
> > -	if (length)
> > +	if (length) {
> > +		pr_warn("SELinux: %s: failed to load policy
> > capabilities\n",
> > +		       __func__);
> >  		goto out1;
> > +	}
> >  
> >  	length = count;
> >  
> > @@ -1299,9 +1311,13 @@ static int sel_make_bools(void)
> >  
> >  		isec = (struct inode_security_struct *)inode-
> > >i_security;
> >  		ret = security_genfs_sid("selinuxfs", page,
> > SECCLASS_FILE, &sid);
> > -		if (ret)
> > +		if (ret) {
> > +			pr_warn_ratelimited("SELinux: %s: failed to
> > lookup sid for %s\n",
> > +					   __func__, page);
> >  			goto out;
> >  
> > +		}
> > +
> >  		isec->sid = sid;
> >  		isec->initialized = LABEL_INITIALIZED;
> >  		inode->i_fop = &sel_bool_ops;

-- 
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=get&search=0x706ED76585AA79D8
