Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Caleb Case <ccase@tresys.com>
In-Reply-To: <1206538884.3302.337.camel@moss-spartans.epoch.ncsc.mil>
References: <47E7E7A5.6090603@manicmethod.com>
	 <1206463352.3302.200.camel@moss-spartans.epoch.ncsc.mil>
	 <47E965AE.8090804@manicmethod.com>
	 <1206535700.3302.294.camel@moss-spartans.epoch.ncsc.mil>
	 <47EA4FC5.6000907@manicmethod.com>
	 <1206538884.3302.337.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 26 Mar 2008 09:57:51 -0400
Message-Id: <1206539871.3302.341.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-26 at 09:41 -0400, Stephen Smalley wrote:
> On Wed, 2008-03-26 at 09:29 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Tue, 2008-03-25 at 16:50 -0400, Joshua Brindle wrote:
> > >   
> > >> Stephen Smalley wrote:
> > >>     
> > >>> On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
> > >>>   
> > >>>       
> > >>>> This implements user_transition in the toolchain. It should help on
> > >>>> distro's like Ubuntu that can't use run_init due to the user not knowing
> > >>>> the root password. It also seems like a more eloquent way to handle
> > >>>> service restarts than assigning system_r to user accounts and having the
> > >>>> daemons run as someuser:system_r:foo_t.
> > >>>>
> > >>>> This has some issues in policy due to users not always being known in
> > >>>> the policy (eg., semanage users). I hope Chris or Dan will be able to
> > >>>> give some suggestions there.
> > >>>>
> > >>>> The kernel patch (forthcoming after this is accepted) so far only
> > >>>> implements the transition on process transitions. Later on I plan on
> > >>>> doing a patch to expand role_transition to object classes (this is a
> > >>>> change needed for policy rbac support to work). I suspect I'll do the
> > >>>> same for user at that time. The question here is, do we think its worth
> > >>>> it to do fine grained transitions like we did for range_trans? (I don't).
> > >>>>
> > >>>> Index: libsepol/include/sepol/policydb/policydb.h
> > >>>> ===================================================================
> > >>>> --- libsepol/include/sepol/policydb/policydb.h	(revision 2854)
> > >>>> +++ libsepol/include/sepol/policydb/policydb.h	(working copy)
> > >>>> @@ -156,6 +156,14 @@
> > >>>> 	mls_level_t exp_dfltlevel; /* expanded range used for validation */
> > >>>> } user_datum_t;
> > >>>>
> > >>>> +typedef struct user_trans {
> > >>>> +	uint32_t user;		/* current role */
> > >>>> +	uint32_t type;		/* program executable type */
> > >>>> +	uint32_t new_user;	/* new role */
> > >>>> +	struct user_trans *next;
> > >>>> +} user_trans_t;
> > >>>> +
> > >>>> +
> > >>>> /* Sensitivity attributes */
> > >>>> typedef struct level_datum {
> > >>>> 	mls_level_t *level;	/* sensitivity and associated categories */
> > >>>> @@ -225,6 +233,13 @@
> > >>>> 	struct role_trans_rule *next;
> > >>>> } role_trans_rule_t;
> > >>>>
> > >>>> +typedef struct user_trans_rule {
> > >>>> +	ebitmap_t users;	/* current role */
> > >>>> +	type_set_t types;	/* program executable type */
> > >>>> +	uint32_t new_user;	/* new role */
> > >>>> +	struct user_trans_rule *next;
> > >>>> +} user_trans_rule_t;
> > >>>>     
> > >>>>         
> > >>> Possibly crazy idea - given the current trend, would it be better to
> > >>> just save the user transition rules in symbolic form in the module
> > >>> format.  Would that simplify the link/expand code?
> > >>>
> > >>>   
> > >>>       
> > >> Possibly, I am hoping policyrep will supplant this code in the near 
> > >> future so I didn't think about it much. This is consistent with how we 
> > >> store other modular things.
> > >>
> > >>     
> > >>>> Index: libsepol/src/policydb.c
> > >>>> ===================================================================
> > >>>> --- libsepol/src/policydb.c	(revision 2854)
> > >>>> +++ libsepol/src/policydb.c	(working copy)
> > >>>> @@ -348,6 +367,30 @@
> > >>>> 	}
> > >>>> }
> > >>>>
> > >>>> +void user_trans_rule_init(user_trans_rule_t * x)
> > >>>> +{
> > >>>> +	memset(x, 0, sizeof(*x));
> > >>>>     
> > >>>>         
> > >>> Not unique to this patch, but it seems funny that we use memset followed
> > >>> by explicit initializers for fields that have them.  And that as a
> > >>> result of the memset here, we don't calloc when allocate the structs.
> > >>>
> > >>>   
> > >>>       
> > >> I would normally never memset a struct, rather than use an initializer 
> > >> but I was going for minimal changes here, I don't plan on this code 
> > >> being around for long.
> > >>     
> > >
> > > Famous last words.  Don't ever make that assumption ;)
> > > Especially given life cycles of distributions that might incorporate
> > > said code.
> > >   
> > 
> > I know, I typed it tongue-in-cheek.
> > 
> > > I know that this is consistent with how we store other modular things
> > > and that policyrep will "make all things better".  But I'm wondering
> > > whether you could have greatly simplified even this "transient"
> > > implementation of user transition support by keeping it in symbolic
> > > form, even within a "binary" module format, to simplify linking and
> > > reduce likelihood of mapping errors.
> > >
> > >   
> > 
> > I understand and if there were more time I wouldn't mind doing it. Right 
> > now I wanted to push these through as fast as possible so that we could 
> > maybe get them in to Hardy, which as of right now has no solution to 
> > restart services other than rebooting.
> 
> Rushing through a new feature considered harmful.  Look, Fedora has
> lived for years without this feature and works fine, albeit requiring
> adding system_r to user accounts and enabling DIRECT_INITRC=y in
> build.conf.

Seriously - this sounds like a recipe for disaster; the last thing we
want is to risk de-stabilizing the Ubuntu kernel with a last minute
change, making selinux unusable there.  Why not just follow the example
of Fedora (and I assume Debian?) here for now and use the above
workaround in policy, then you can switch to user transitions in the
future once this feature has had time to bake in -mm for a bit and then
gone into the mainline kernel.

> > This method is well understood in this codebase and chances are in 
> > mapping is broken one place its broken in five so I'm not entirely sure 
> > what it would gain us now.
> > 
> > On the note of getting this out quickly I'm hitting this strange kernel 
> > but where class_read says a common is unknown when I try to load a 23 
> > policy, I'm currently working through that but building ubuntu kernels 
> > takes hours :X
> 
> Cute.  But a good example of why we shouldn't rush this out.  And even
> if it is implemented tomorrow, what is the likelihood that the Ubuntu
> kernel folks are going to want to pull it into their existing kernel for
> this release - at such a late date?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
