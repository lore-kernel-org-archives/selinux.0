From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <pmoore@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Paul Osmialowski <p.osmialowsk@samsung.com>
Subject: Re: [RFC PATCH v3 3/5] lsm: add support for auditing kdbus service
 names
Date: Fri, 09 Oct 2015 12:25:55 -0400
Message-ID: <1800266.KI1jez7jKq@x2>
In-Reply-To: <5617D5E8.3000305@tycho.nsa.gov>
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230835.7823.5818.stgit@localhost> <5617D5E8.3000305@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, October 09, 2015 10:57:44 AM Stephen Smalley wrote:
> On 10/07/2015 07:08 PM, Paul Moore wrote:
> > The kdbus service names will be recorded using 'service', similar to
> > the existing dbus audit records.
> > 
> > Signed-off-by: Paul Moore <pmoore@redhat.com>
> > 
> > ---
> > ChangeLog:
> > - v3
> > 
> >   * Ported to the 4.3-rc4 based kdbus tree
> > 
> > - v2
> > 
> >   * Initial draft
> > 
> > ---
> > 
> >   include/linux/lsm_audit.h |    2 ++
> >   security/lsm_audit.c      |    4 ++++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > index ffb9c9d..d6a656f 100644
> > --- a/include/linux/lsm_audit.h
> > +++ b/include/linux/lsm_audit.h
> > @@ -59,6 +59,7 @@ struct common_audit_data {
> > 
> >   #define LSM_AUDIT_DATA_INODE	9
> >   #define LSM_AUDIT_DATA_DENTRY	10
> >   #define LSM_AUDIT_DATA_IOCTL_OP	11
> > 
> > +#define LSM_AUDIT_DATA_KDBUS	12
> > 
> >   	union 	{
> >   	
> >   		struct path path;
> >   		struct dentry *dentry;
> > 
> > @@ -75,6 +76,7 @@ struct common_audit_data {
> > 
> >   #endif
> >   
> >   		char *kmod_name;
> >   		struct lsm_ioctlop_audit *op;
> > 
> > +		const char *kdbus_name;
> > 
> >   	} u;
> >   	/* this union contains LSM specific data */
> >   	union {
> > 
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index cccbf30..0a3dc1b 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -397,6 +397,10 @@ static void dump_common_audit_data(struct
> > audit_buffer *ab,> 
> >   		audit_log_format(ab, " kmod=");
> >   		audit_log_untrustedstring(ab, a->u.kmod_name);
> >   		break;
> > 
> > +	case LSM_AUDIT_DATA_KDBUS:
> > +		audit_log_format(ab, " service=");
> 
> Not a major issue to me, but just wondering if this needs to be further
> qualified to indicate it is a kdbus service.  service= is rather generic.

>From the audit perspective, its fine as service. Too many names that mean the 
same thing causes string lookup tables to get big. Service is what dbus is 
currently using. So, it makes sense to re-use the field name. If the selinux 
tooling wants to know an AVC originated from kdbus activity, then maybe 
another name=value should be added.

-Steve
 
> > +		audit_log_untrustedstring(ab, a->u.kdbus_name);
> > +		break;
> > 
> >   	} /* switch (a->type) */
> >   
> >   }
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit
