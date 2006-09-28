Subject: Re: [PATCH] newrole auditing of failures due to user actions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <451C2B03.1060300@us.ibm.com>
References: <451C2473.7050102@us.ibm.com>  <451C2B03.1060300@us.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 16:29:22 -0400
Message-Id: <1159475362.14884.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 15:05 -0500, Michael C Thompson wrote:
> Michael C Thompson wrote:
> > This patch introduces two new point in the code where audit records are 
> > generated for newrole. Both points are when the attempt to newrole fails.

In addition to my prior comments about the #ifdefs:

> > --- policycoreutils-1.30.29/newrole/newrole.c	2006-09-14 07:07:26.000000000 -0500
> > +++ policycoreutils-1.30.29.orig.dev/newrole/newrole.c	2006-09-28 14:21:27.000000000 -0500
> > @@ -394,6 +396,41 @@
> > +/* Send audit message */
> > +int send_audit_message(int success, security_context_t old_context,
> > +			security_context_t new_context, const char *ttyn)
> > +{
> > +	char *msg = NULL;
> > +	int rc;
> > +	int audit_fd = audit_open();
> > +
> > +	if (audit_fd < 0) {
> > +		fprintf(stderr, _("Error connecting to audit system.\n"));
> > +		rc = -1;
> > +		goto out;

I think you just want to return -1 here, as there is no cleanup to be
done at this point and the out path will try to do a close(audit_fd)
i.e. close(-1) in this case, which isn't legal.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
