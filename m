Subject: Re: [PATCH 2/4] SELinux: move genfs read to a separate function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1276697931.17827.3.camel@moss-pluto.epoch.ncsc.mil>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163711.18445.85854.stgit@paris.rdu.redhat.com>
	 <1276697931.17827.3.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 10:24:27 -0400
Message-ID: <1276698267.17827.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-16 at 10:18 -0400, Stephen Smalley wrote:
> On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> > move genfs read functionality out of policydb_read() and into a new
> > function called genfs_read()
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/ss/policydb.c |  236 ++++++++++++++++++++++------------------
> >  1 files changed, 131 insertions(+), 105 deletions(-)
> > 
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index a39d38a..66e217b 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1773,6 +1776,129 @@ out:
> >  	return rc;
> >  }
> >  
> > +static int genfs_read(struct policydb *p, void *fp)
> > +{
> > +	int i, j, rc;
> > +	u32 nel, nel2, len, len2;
> > +	__le32 buf[1];
> > +	struct ocontext *l, *c;
> > +	struct ocontext *newc = NULL;
> > +	struct genfs *genfs_p, *genfs;
> > +	struct genfs *newgenfs = NULL;
> > +
> > +	rc = next_entry(buf, fp, sizeof(u32));
> > +	if (rc < 0)
> > +		goto out;
> > +	nel = le32_to_cpu(buf[0]);
> > +
> > +	for (i = 0; i < nel; i++) {
> > +		rc = next_entry(buf, fp, sizeof(u32));
> > +		if (rc)
> > +			goto out;
> > +		len = le32_to_cpu(buf[0]);
> > +
> > +		rc = -ENOMEM;
> > +		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
> > +		if (!newgenfs)
> > +			goto out;
> > +
> > +		rc = -ENOMEM;
> > +		newgenfs->fstype = kmalloc(len + 1, GFP_KERNEL);
> > +		if (!newgenfs->fstype)
> > +			goto out;
> > +
> > +		rc = next_entry(newgenfs->fstype, fp, len);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		newgenfs->fstype[len] = 0;
> > +
> > +		for (genfs_p = NULL, genfs = p->genfs; genfs;
> > +		     genfs_p = genfs, genfs = genfs->next) {
> > +			rc = -EEXIST;
> > +			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
> > +				printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
> > +				       newgenfs->fstype);
> > +				goto out;
> > +			}
> > +			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
> > +				break;
> > +		}
> > +		newgenfs->next = genfs;
> > +		if (genfs_p)
> > +			genfs_p->next = newgenfs;
> > +		else
> > +			p->genfs = newgenfs;
> > +		genfs = newgenfs;
> > +		newgenfs = NULL;
> > +
> > +		rc = next_entry(buf, fp, sizeof(u32));
> > +		if (rc)
> > +			goto out;
> > +
> > +		nel2 = le32_to_cpu(buf[0]);
> > +		for (j = 0; j < nel2; j++) {
> > +			rc = next_entry(buf, fp, sizeof(u32));
> > +			if (rc)
> > +				goto out;
> > +			len = le32_to_cpu(buf[0]);
> > +
> > +			rc = -ENOMEM;
> > +			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
> > +			if (!newc)
> > +				goto out;
> > +
> > +			rc = -ENOMEM;
> > +			newc->u.name = kmalloc(len + 1, GFP_KERNEL);
> > +			if (!newc->u.name)
> > +				goto out;
> > +
> > +			rc = next_entry(newc->u.name, fp, len);
> > +			if (rc)
> > +				goto out;
> > +			newc->u.name[len] = 0;
> > +
> > +			rc = next_entry(buf, fp, sizeof(u32));
> > +			if (rc)
> > +				goto out;
> > +
> > +			newc->v.sclass = le32_to_cpu(buf[0]);
> > +			rc = context_read_and_validate(&newc->context[0], p, fp);
> > +			if (rc)
> > +				goto out;
> > +
> > +			for (l = NULL, c = genfs->head; c;
> > +			     l = c, c = c->next) {
> > +				if (!strcmp(newc->u.name, c->u.name) &&
> > +				    (!c->v.sclass || !newc->v.sclass ||
> > +				     newc->v.sclass == c->v.sclass)) {
> > +					printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
> > +					       genfs->fstype, c->u.name);
> > +					goto out;
> 
> rc wasn't set.
> 
> > +				}
> > +				len = strlen(newc->u.name);
> > +				len2 = strlen(c->u.name);
> > +				if (len > len2)
> > +					break;
> > +			}
> > +
> > +			newc->next = c;
> > +			if (l)
> > +				l->next = newc;
> > +			else
> > +				genfs->head = newc;
> > +			newc = NULL;
> > +		}
> > +	}

Also, for safety, shouldn't we explicitly set rc = 0; here so that no
prior assignment of rc will fall through.  Regardless of whether that is
possible with the current code - just do it now for maintainability.

> > +out:
> > +	if (newgenfs)
> > +		kfree(newgenfs->fstype);
> > +	kfree(newgenfs);
> > +	ocontext_destroy(newc, OCON_FSUSE);
> > +
> > +	return rc;
> > +}
> > +
> >  /*
> >   * Read the configuration data from a policy database binary
> >   * representation file into a policy database structure.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
