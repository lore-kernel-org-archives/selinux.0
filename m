Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PFmf6f017802
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 11:48:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2PFmeh6001378
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 15:48:40 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
Date: Tue, 25 Mar 2008 09:24:53 -0400
Message-ID: <1206451493.16113.217.camel@gorn.columbia.tresys.com>
In-Reply-To: <47E8D58B.5040707@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com> <1204922912.20251.58.camel@gorn.columbia.tresys.com> <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn> <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn> <47E33A66.6030705@ak.jp.nec.com> <1206384282.16113.205.camel@gorn.columbia.tresys.com> <47E8D58B.5040707@ak.jp.nec.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: "KaiGai Kohei" <kaigai@kaigai.gr.jp>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-03-25 at 19:35 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Fri, 2008-03-21 at 13:32 +0900, KaiGai Kohei wrote:
> >> Chris, Thanks for your reviewing.
> >>
> >> Rest of comments are bellow.
> >>
> >> Christopher J. PeBenito wrote:
> >>> On Mon, 2008-03-17 at 18:31 +0900, Kohei KaiGai wrote:
> >>>> The attached patch provides revised SE-PostgreSQL policy.
> > 
> >>>> +template(`postgresql_userdom_template',`
> >>   - snip -
> >>>> +       ##############################
> >>>> +       #
> >>>> +       # Client local policy
> >>>> +       #
> >>>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_table     sepgsql_$1_table_t;
> >>>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_$1_proc_t;
> >>>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_blob      sepgsql_$1_blob_t;
> >>>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_sysobj_t      : db_tuple     sepgsql_$1_sysobj_t;
> > 
> > I missed this previously but I just realized that to be consistent with
> > the rest of the policy the prefix should actually be a prefix, not
> > infix.  i.e. the types should be like $1_sepgsql_table_t not sepgsql_
> > $1_table_t.
> 
> I want to keep "sepgsql_" as a prefix for types related to SE-PostgreSQL,
> because all of them have uniformed naming convention.
> Can you consider the head of "sepgsql_" means its assumed object manager,
> and we are omitting it for most of types managed by kernel?
> I feel that object manager identification should have higher priority than
> user domain prefix in naming convention.
> In my sense, "kernel_user_home_t" is better than "user_kernel_home_t",
> if object manager identification is not omitted.
> 
> However, it is just a name. I don't oppose this strongly.

I think we want consistency across the policy in naming.  Determining if
it goes with a userspace object manager can be found based on what
object classes have the label.

> >>> This should probably transition even if its unconfined.  If a user
> >>> starts out unconfined and then the admin later decides the user should
> >>> be confined, the user will lose access to its object, right?
> >> No. In this case, a new confined user can access to its object if it was
> >> not explicitly relabeled.
> >> The default type of db_table class created by unconfined users is sepgsql_table_t.
> >> Any confined users can also access to them with restricted permissions.
> > 
> > I finally realized what the problem with the type_transitions.  You have
> > many of them to set up the default type for tables, procedures, blobs,
> > etc.  Shouldn't the default labels just be settings in a config file?
> > Then all of the complex type transitioning behavior isn't needed.
> 
> I dislike thie option.
> It can make harder to find out the cause of trouble came from labeling behavior,
> if end users put incorrect configuration. Especially, I don't want to require
> database folks additional configuration, because they are not SELinux specialist.
> It can be configured in the security policy enough simply, so the default behavior
> should be also described in.

I think I was a little unclear.  I'm suggesting they go in a file
like /etc/selinux/refpolicy/contexts/postgresql_contexts, not in a
primary config file for postgresql.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
