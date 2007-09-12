Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CDQnc3023648
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 09:26:49 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CDQlsM000688
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 13:26:48 GMT
Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <46E71D60.8010501@manicmethod.com>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E71D60.8010501@manicmethod.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 09:26:35 -0400
Message-Id: <1189603595.3555.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-11 at 18:57 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > So there was a brief conversation between dan, karl, and myself today
> > about implementing a permissive subject domain.  Basically there would
> > be some new language construct possibly "permissive httpd_t true;" which
> > would then set a flag.  If this flag was set, all denials would be
> > logged but the operation would be permitted.  This would make it
> > possible to create a type_exec_t and type_t for your new domain, mark it
> > as permissive/unconfined and run it as long as you like.  Once you get
> > all your new allow rules you just remove the permissive bit.  You didn't
> > have to setenforce the whole system.
> >
> > First thought from Karl was to use the 'char primary' field of the
> > struct type_datum.  Seems reasonable enough, after we have that
> > information in kernel it shouldn't take me too much playing around in
> > avc_has_perm_noaudit to check if this flag is set on a denial.  I don't
> > think slowing down the denial path a little by having to call back in to
> > see if this flag was set for a given source sid is that big of deal.
> > Maybe I could keep it just about as fast by adding more flags
> > audit_allow_once (can't really reuse audit_allow) to the avd or
> > something like that, but it seems like a large waste of space to carry
> > another set of audit flags that won't be used much.
> >
> > Thoughts?  Other ways to implement this?  Problems with the basic premis
> > of an unconfined domain?
> >   
> 
> This is asking for all kinds of problems. Writes to directories without 
> type transitions means after a policy is written, if the correct 
> refpolicy interface is used that defines a transition, then any files 
> written during 'permissive mode' won't be accessible.

The type transitions should continue to occur just like in global
permissive.

>  Domain transitions 
> are in the same boat, imagine what domains processes could end up 
> running in during this.

Again, the domain transitions should happen normally. How is this
different from using global permissive for policy development?

>  We need to tread very carefully here, and there 
> are interesting ramifications to transitioning to and from the 
> permissive domains during runtime. If an application has a transition to 
> the permissive domain a new attack vector was just introduced. I know 
> this can be helpful and its better than running the entire system in 
> permissive but it can also be dangerous.
> 

Of course it could be dangerous - but it would also be incredibly
useful. And how is it worse than an unconfined domain?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
