Subject: RE: [PATCH] checkpolicy: add support for using last path component
 in type transition rules
From: Eric Paris <eparis@redhat.com>
To: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "method@manicmethod.com" <method@manicmethod.com>,
        "sds@tycho.nsa.gov"
 <sds@tycho.nsa.gov>
Date: Tue, 29 Mar 2011 11:38:43 -0400
In-Reply-To: <A9F5079BABDEE646AEBDB6831725762C52B55492E0@EUEXCLU01.EU.NEC.COM>
References: <1301335220.14296.27.camel@localhost.localdomain>
	 <A9F5079BABDEE646AEBDB6831725762C52B55492E0@EUEXCLU01.EU.NEC.COM>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1301413124.14296.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-03-29 at 10:28 +0100, Kohei Kaigai wrote:
> > This patch adds support for using the last path component as part of the
> > information in making labeling decisions for new objects.  A example
> > rule looks like so:
> >
> > type_transition unconfined_t etc_t:file system_conf_t eric;
> >
> > This rule says if unconfined_t creates a file in a directory labeled
> > etc_t and the last path component is "eric" (no globbing, no matching
> > magic, just exact strcmp) it should be labeled system_conf_t.
> >
> It seems to me quite useful for my project also.
> (Sorry, I overlooked your proposition on the December.)
> 
> Similarly, we might use these rules like:
> 
> Type_transition unconfined_t sepgsql_db_t:db_schema sepgsql_temp_schema_t pg_temp;
> 
> This rule says if unconfined_t tries to create a schema object in a database
> labelled sepgsql_db_t and the name component is "pg_temp" that means a schema
> to store temporary objects.
> 
> We need to modify userspace interface to support this new feature, don't we?
> 
> Probably, it has the following prototype,
> 
>   int security_compute_create_name(const security_context_t *scontext,
>                                    const security_context_t *tcontext,
>                                    security_class_t tclass,
>                                    security_context_t *newcon,
>                                    const char *object_name);
> 
> And, selinuxfs needs to accept the fourth argument optionally on /selinux/create.

Seems quite reasonable.

> > The kernel and policy representation does not have support for such
> > rules in conditionals, and thus policy explicitly notes that fact if
> > such a rule is added to a conditional.
> >
> Does it has technically difficulties? Or, just a current limitation?

The module format doesn't store these rules in a conditional block.  So
that would need to change.  The kernel doesn't have a method to look for
these rules in conditionals, so that would need to change.  I mean,
anything is possible, but I don't plan to do it....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
