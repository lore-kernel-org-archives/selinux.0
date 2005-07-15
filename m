Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FJWkgA013998
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:32:46 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FJT8rE018635
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 19:29:09 GMT
Subject: Re: [RFC] selinux management API
From: Joshua Brindle <jbrindle@tresys.com>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1121455199.10134.15.camel@celtics.boston.redhat.com>
References: <42D7CC53.9030803@tresys.com>
	 <1121442990.4488.87.camel@celtics.boston.redhat.com>
	 <42D7FC9A.7000901@tresys.com>
	 <1121455199.10134.15.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:29:03 -0400
Message-Id: <1121455743.28369.36.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-15 at 15:19 -0400, Ivan Gyurdiev wrote:
> int semanage_user_remove(semanage_handle_t *, semanage_user_t
> *userdata);
> 
> You want to remove based on name, not based on a full
> data structure. Similarly there should be a query function.
> 
But maybe not in the future, this is meant to be future-proof

and the query functions can be added in, but those are convenience
functions and have nothing to do with the design we are proposing here.

> void semanage_user_free(semanage_user_t *);
> 
> Seems to me like the free functions should be declared
> with the other handlers for their corresponding opaque 
> data structure (which are not shown here).

eh? 
void semanage_module_info_free(semanage_module_info_t *);
void semanage_homedir_free(semanage_homedir_t *);
void semanage_boolean_free(semanage_boolean_t *);
void semanage_tunable_free(semanage_tunable_t *);

all of the structures have free's


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
