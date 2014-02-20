From: Paul Moore <pmoore@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] SELinux: bigendian problems with filename trans rules
Date: Thu, 20 Feb 2014 13:24:26 -0500
Message-ID: <1813237.KIV3iSxS5b@sifl>
In-Reply-To: <53064615.2010503@tycho.nsa.gov>
References: <1392911805-8186-1-git-send-email-eparis@redhat.com>
 <53064615.2010503@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, February 20, 2014 01:14:45 PM Stephen Smalley wrote:
> On 02/20/2014 10:56 AM, Eric Paris wrote:
> > When writing policy via /sys/fs/selinux/policy I wrote the type and class
> > of filename trans rules in CPU endian instead of little endian.  On
> > x86_64 this works just fine, but it means that on big endian arch's like
> > ppc64 and s390 userspace reads the policy and converts it from
> > le32_to_cpu.  So the values are all screwed up.  Write the values in le
> > format like it should have been to start.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/ss/policydb.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/selinux/ss/policydb.c
> > b/security/selinux/ss/policydb.c index c0f4988..9c5cdc2 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -3338,10 +3338,10 @@ static int filename_write_helper(void *key, void
> > *data, void *ptr)> 
> >  	if (rc)
> >  	
> >  		return rc;
> > 
> > -	buf[0] = ft->stype;
> > -	buf[1] = ft->ttype;
> > -	buf[2] = ft->tclass;
> > -	buf[3] = otype->otype;
> > +	buf[0] = cpu_to_le32(ft->stype);
> > +	buf[1] = cpu_to_le32(ft->ttype);
> > +	buf[2] = cpu_to_le32(ft->tclass);
> > +	buf[3] = cpu_to_le32(otype->otype);
> > 
> >  	rc = put_entry(buf, sizeof(u32), 4, fp);
> >  	if (rc)
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied, thanks.

-- 
paul moore
security and virtualization @ redhat
