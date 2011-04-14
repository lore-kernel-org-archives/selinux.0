Subject: Re: [PATCH] libsepol: support policy modules when roletrans rules
 not supported
From: Eric Paris <eparis@redhat.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@parisplace.org>, Steve Lawrence <slawrence@tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "qingtao.cao@windriver.com" <qingtao.cao@windriver.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4DA6FD94.1050302@manicmethod.com>
References: <1302642701-15441-1-git-send-email-eparis@redhat.com>
	 <4DA5BFF0.2090209@tresys.com>	<4DA5DEDB.9020005@tresys.com>
	 <1302718034.8639.4.camel@unknown001a4b0c2895>
	 <BANLkTinU3TutCwDNA9eROjAjY+xXmztH1g@mail.gmail.com>
	 <4DA6FD94.1050302@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 10:19:01 -0400
Message-ID: <1302790741.9684.15.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-04-14 at 09:58 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > So I'm questioning the correctness of the range_transition and
> > role_transition rules in libsepol.  My main problem is that libsepol
> > defines SECCLASS_* at all.  Right now if the policy reads in one of
> > these rules types without a tclass it will set SECCLASS_PROCESS in the
> > tclasses bitmap.  But we never had any that would declare what the
> > means.  At link time when we have to map "process" in a module to
> > "process" in the base policy.  But if the module didn't require
> > "process" it won't have the mapping.  So the fact that we set the
> > SECCLASS_PROCESS bit could cause it to get mapped to random crap (or
> > nothing at all)  Right?
> >
> > I know it's ugly but I think we need to do a couple of things.  #1 on
> > that list is get SECCLASS_* out of libsepol altogether.  Those are
> > COMPLETELY a construct of policy.  Not libsepol.  After we remove all
> > of those we need to change the logic of everything that uses them to
> > instead make sure that the "process" class exists in it's definitions
> > and if not declare it.  Then set the bitmap for that new object.
> >
> > Am I not understanding something about how using SECCLASS_PROCESS
> > could ever be a good idea?
> 
> It isn't the first time we've had hardcoded symbols that have to be mapped in 
> the code. See OBJECT_R_VAL as an example.
> 
> It is a bit wonky though, suppose a type_transition rule were in a XenSE policy, 
> I don't think they have a process object class.

So what it sounds like is that I probably want to look up the "process"
class every time I would have used SECCLASS_PROCESS and if I don't find
it, create it, and then look it up.  In this manor a policy which
doesn't have process at all wouldn't have it forcibly jammed upon it
(like we do in roles_init for OBJECT_R_VAL) and we wouldn't be mapping
rules to garbage.  Sound right/ok to others?

-Eric
> 
> >
> > -Eric
> >
> > On Wed, Apr 13, 2011 at 2:07 PM, Eric Paris<eparis@redhat.com>  wrote:
> >> On Wed, 2011-04-13 at 13:35 -0400, Steve Lawrence wrote:
> >>> On 04/13/2011 11:23 AM, Steve Lawrence wrote:
> >>>> Thanks for the patch. This solves the problem, but I'm still seeing
> >>>> issues that seems related to support of older version of policy when
> >>>> using role_transition with non-process classes. I'm now seeing an mls
> >>>> range overflow error:
> >>>>
> >>>> libsepol.role_trans_write: Discarding role_transition rules for security
> >>>> class other than "process"
> >>>> libsepol.mls_read_range_helper: range overflow
> >>>> libsepol.context_read_and_validate: error reading MLS range of context
> >>>> libsepol.policydb_to_image: new policy image is invalid
> >>>>
> >>>> I'm still looking into it, but I'm not too familiar this part of the code.
> >>>>
> >>>>
> >>>> On 04/12/2011 05:11 PM, Eric Paris wrote:
> >>>>> Although the role trans code had support to handle the kernel policy
> >>>>> when the version was less that roletrans such support was not in the
> >>>>> module read/write code.  This patch adds proper support for role trans
> >>>>> in modules.
> >>>>>
> >>>>> Signed-off-by: Eric Paris<eparis@redhat.com>
> >>>>> ---
> >>>>>   libsepol/src/policydb.c |   14 ++++++++++----
> >>>>>   libsepol/src/write.c    |   37 ++++++++++++++++++++++++++++++++-----
> >>>>>   2 files changed, 42 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> >>>>> index 2ecb636..6d8ff91 100644
> >>>>> --- a/libsepol/src/policydb.c
> >>>>> +++ b/libsepol/src/policydb.c
> >>>>> @@ -3033,7 +3033,8 @@ int avrule_read_list(policydb_t * p, avrule_t ** avrules,
> >>>>>     return 0;
> >>>>>   }
> >>>>>
> >>>>> -static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
> >>>>> +static int role_trans_rule_read(policydb_t *p, role_trans_rule_t ** r,
> >>>>> +                          struct policy_file *fp)
> >>>>>   {
> >>>>>     uint32_t buf[1], nel;
> >>>>>     unsigned int i;
> >>>>> @@ -3064,8 +3065,13 @@ static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
> >>>>>             if (type_set_read(&tr->types, fp))
> >>>>>                     return -1;
> >>>>>
> >>>>> -          if (ebitmap_read(&tr->classes, fp))
> >>>>> -                  return -1;
> >>>>> +          if (p->policyvers>= MOD_POLICYDB_VERSION_ROLETRANS) {
> >>>>> +                  if (ebitmap_read(&tr->classes, fp))
> >>>>> +                          return -1;
> >>>>> +          } else {
> >>>>> +                  if (ebitmap_set_bit(&tr->classes, SECCLASS_PROCESS - 1, 1))
> >>>>> +                          return -1;
> >>>>> +          }
> >>>>>
> >>>>>             rc = next_entry(buf, fp, sizeof(uint32_t));
> >>>>>             if (rc<  0)
> >>>>> @@ -3258,7 +3264,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
> >>>>>     decl->enabled = le32_to_cpu(buf[1]);
> >>>>>     if (cond_read_list(p,&decl->cond_list, fp) == -1 ||
> >>>>>         avrule_read_list(p,&decl->avrules, fp) == -1 ||
> >>>>> -      role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
> >>>>> +      role_trans_rule_read(p,&decl->role_tr_rules, fp) == -1 ||
> >>>>>         role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
> >>>>>             return -1;
> >>>>>     }
> >>>>> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> >>>>> index c4f5035..78b3aa6 100644
> >>>>> --- a/libsepol/src/write.c
> >>>>> +++ b/libsepol/src/write.c
> >>>>> @@ -1482,26 +1482,53 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
> >>>>>     return POLICYDB_SUCCESS;
> >>>>>   }
> >>>>>
> >>>>> -static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
> >>>>> +static int only_process(ebitmap_t *in)
> >>>>> +{
> >>>>> +  unsigned int i;
> >>>>> +  ebitmap_node_t *node;
> >>>>> +
> >>>>> +  ebitmap_for_each_bit(in, node, i) {
> >>>>> +          if (ebitmap_node_get_bit(node, i)&&
> >>>>> +              i != SECCLASS_PROCESS - 1)
> >>>>> +                  return 0;
> >>>>> +  }
> >>>>> +  return 1;
> >>>>> +}
> >>>>> +
> >>>>> +static int role_trans_rule_write(policydb_t *p, role_trans_rule_t * t,
> >>>>> +                           struct policy_file *fp)
> >>>>>   {
> >>>>>     int nel = 0;
> >>>>>     size_t items;
> >>>>>     uint32_t buf[1];
> >>>>>     role_trans_rule_t *tr;
> >>>>> +  int warned = 0;
> >>>>> +  int new_role = p->policyvers>= MOD_POLICYDB_VERSION_ROLETRANS;
> >>>>>
> >>>>>     for (tr = t; tr; tr = tr->next)
> >>>>> -          nel++;
> >>>>> +          if (new_role || only_process(&tr->classes))
> >>>>> +                  nel++;
> >>>>> +
> >>>>>     buf[0] = cpu_to_le32(nel);
> >>>>>     items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >>>>>     if (items != 1)
> >>>>>             return POLICYDB_ERROR;
> >>>>>     for (tr = t; tr; tr = tr->next) {
> >>>>> +          if (!new_role&&  !only_process(&tr->classes)) {
> >>>>> +                  if (!warned)
> >>>>> +                          WARN(fp->handle, "Discarding role_transition "
> >>>>> +                                  "rules for security classes other than "
> >>>>> +                                  "\"process\"");
> >>>>> +                  warned = 1;
> >>>>> +                  continue;
> >>>>> +          }
> >>>>>             if (role_set_write(&tr->roles, fp))
> >>>>>                     return POLICYDB_ERROR;
> >>>>>             if (type_set_write(&tr->types, fp))
> >>>>>                     return POLICYDB_ERROR;
> >>>>> -          if (ebitmap_write(&tr->classes, fp))
> >>>>> -                  return POLICYDB_ERROR;
> >>>>> +          if (new_role)
> >>>>> +                  if (ebitmap_write(&tr->classes, fp))
> >>>>> +                          return POLICYDB_ERROR;
> >>>>>             buf[0] = cpu_to_le32(tr->new_role);
> >>>>>             items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >>>>>             if (items != 1)
> >>>>> @@ -1636,7 +1663,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
> >>>>>     }
> >>>>>     if (cond_write_list(p, decl->cond_list, fp) == -1 ||
> >>>>>         avrule_write_list(decl->avrules, fp) == -1 ||
> >>>>> -      role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
> >>>>> +      role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
> >>>>>         role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
> >>>>>             return POLICYDB_ERROR;
> >>>>>     }
> >>>>
> >>>> --
> >>>> This message was distributed to subscribers of the selinux mailing list.
> >>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >>>> the words "unsubscribe selinux" without quotes as the message.
> >>> I think the below patch fixes the problem I was seeing. Some rules were
> >>> getting discarded in role_trans_write during a policy downgrade, but the
> >>> count was not being decreased. This fix is similar to your fix in
> >>> role_trans_rule_write.
> >> Looks as appropriate to me as when range trans does it.
> >>
> >> -Eric
> >>
> >>> ---
> >>> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> >>> index 78b3aa6..3a9c35a 100644
> >>> --- a/libsepol/src/write.c
> >>> +++ b/libsepol/src/write.c
> >>> @@ -474,7 +474,9 @@ static int role_trans_write(policydb_t *p, struct
> >>> policy_file *fp)
> >>>
> >>>      nel = 0;
> >>>      for (tr = r; tr; tr = tr->next)
> >>> -       nel++;
> >>> +       if(new_roletr || tr->class == SECCLASS_PROCESS)
> >>> +           nel++;
> >>> +
> >>>      buf[0] = cpu_to_le32(nel);
> >>>      items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >>>      if (items != 1)
> >>
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >> the words "unsubscribe selinux" without quotes as the message.
> >>
> >



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
