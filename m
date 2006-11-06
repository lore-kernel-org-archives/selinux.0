Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6Gew8A003763
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 11:41:01 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6GeCiG002281
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 16:40:13 GMT
Subject: Re: rpmlint
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <454F61E0.7090705@gentoo.org>
References: <200611030816.22148.sgrubb@redhat.com>
	 <454E6663.8070609@gentoo.org>
	 <1162829020.26148.44.camel@localhost.localdomain>
	 <454F61E0.7090705@gentoo.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:37:47 -0500
Message-Id: <1162831067.26148.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-06 at 11:25 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Sun, 2006-11-05 at 17:32 -0500, Joshua Brindle wrote:
> >> Steve Grubb wrote:
> >>> Hi,
> >>>
> >>> Below is a patch that I am thinking about submitting to rpmlint. The main idea
> >>> of this patch is to catch places where people might be coding policy knowledge
> >>> into scripts. Chcon would require knowing some types in order to work. If the
> >>> types ever got changed, the script would break. Can anyone think of other
> >>> things we do not want to see in rpm scriplets?
> >>>
> >>> -Steve
> >>>
> >>>   
> >> calling semanage thusly:
> >>
> >> semanage fcontext -a [any arguments here] /some/file
> >>
> >> actually any semanage command except *possibly* login and user, and I'm 
> >> not sure they should be there either but someone may have an acceptable 
> >> scenerio.
> > 
> > If we disallow this then what is the recommended way to allow an
> > application to ship a labeling only policy? We need to allow
> > applications to, for example, label a library as textrel_shlib_t without
> > forcing them to ship a policy module.
> > 
> 
> good question, we don't support policy packages without modules now, 
> using types directly breaks any kind of encapsulation the policy may 
> have had so its non-ideal anyway.
> 

Encapsulation at this level is not a goal in my opinion. Encapsulation
is a source construct that helps make the policy _development_
manageable.

It cannot, in any way, help allow implementation changes on a running
system as the identifiers are visible - e.g., types are used on the
filesystem. Users, roles, types, booleans, etc. are well known
identifiers that must be directly referenced to manage a system.

> I think this is a more general problem, how does any given app know that 
> it needs "some label" that gives it the ability to have textrels in its 
> libraries.

I think that the current practice is fine - types have well known
meanings for specific policies.

> > What if we added the ability to specify the store by name (i.e.,
> > semanage -s targeted fcontext -a . . . .). I think it should be
> > acceptable to make assumptions about what a well know policy contains.
> > Getting them to use semanage in this way would fix other problems - like
> > relabeling - without introducing unnecessary policy modules.
> > 
> 
> Store is an arbitrary string that means nothing. Sure this is practical 
> but there are version issues (if a type exists in some version X but not 
> before that, etc).
> 

We are talking about a package targeting a specific system. Targeted for
FC6 is _not_ a random string - it refers to the shipping, default policy
with a known set of fixed types. Can a user install a completely
different "targeted" policy? Of course, but this doesn't happen.

Adding more abstraction here is just going to confuse people - let's go
for the reasonably safe option now that lets people make selinux support
for their packages better without forcing them to jump through too many
hoops. This is Linux not *BSD - let's stop over engineering.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
