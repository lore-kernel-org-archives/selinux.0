Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FK0agA014248
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:00:36 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FJuEBp005636
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 19:56:14 GMT
Subject: Re: [RFC] selinux management API
From: Joshua Brindle <jbrindle@tresys.com>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1121456743.10134.36.camel@celtics.boston.redhat.com>
References: <42D7CC53.9030803@tresys.com>
	 <1121442990.4488.87.camel@celtics.boston.redhat.com>
	 <42D7FC9A.7000901@tresys.com>
	 <1121455199.10134.15.camel@celtics.boston.redhat.com>
	 <1121455743.28369.36.camel@localhost>
	 <1121456743.10134.36.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:57:01 -0400
Message-Id: <1121457421.28365.42.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-15 at 15:45 -0400, Ivan Gyurdiev wrote:
> On Fri, 2005-07-15 at 15:29 -0400, Joshua Brindle wrote:
> > On Fri, 2005-07-15 at 15:19 -0400, Ivan Gyurdiev wrote:
> > > int semanage_user_remove(semanage_handle_t *, semanage_user_t
> > > *userdata);
> > > 
> > > You want to remove based on name, not based on a full
> > > data structure. Similarly there should be a query function.
> > > 
> > But maybe not in the future, this is meant to be future-proof
> 
> Hmm....looks strange, but that's a good point.
> 
> > and the query functions can be added in, but those are convenience
> > functions and have nothing to do with the design we are proposing here.
> 
> You don't seem to like implementation details :)
> 
not during design

> I think it's all about the implementation details...
> the interface is a great guideline, but in the end all of this
> has to be implemented, and it has to be convenient for the caller..
> 

thats fine but we want a future proof, stable, scalable API, the
implementation details will be handled at implementation time.

> > > void semanage_user_free(semanage_user_t *);
> > > 
> > > Seems to me like the free functions should be declared
> > > with the other handlers for their corresponding opaque 
> > > data structure (which are not shown here).
> > 
> > eh? 
> > void semanage_module_info_free(semanage_module_info_t *);
> > void semanage_homedir_free(semanage_homedir_t *);
> > void semanage_boolean_free(semanage_boolean_t *);
> > void semanage_tunable_free(semanage_tunable_t *);
> > 
> > all of the structures have free's
> 
> Yes, I think they should be moved into individual headers for
> each structure, where the accessors, and constructor are defined...
> wherever the constructor is, the free() should accompany it. 

Ah, I get what you mean now. The accessors, constructors, free's, etc
will be in this header since it will be the single exported API file for
libsemanage. They just weren't added to this because they are
implementation details :)

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
