Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6G4qAp002315
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 11:04:52 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6G46iG026445
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 16:04:07 GMT
Subject: Re: rpmlint
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <454E6663.8070609@gentoo.org>
References: <200611030816.22148.sgrubb@redhat.com>
	 <454E6663.8070609@gentoo.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:03:40 -0500
Message-Id: <1162829020.26148.44.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-11-05 at 17:32 -0500, Joshua Brindle wrote:
> Steve Grubb wrote:
> > Hi,
> >
> > Below is a patch that I am thinking about submitting to rpmlint. The main idea
> > of this patch is to catch places where people might be coding policy knowledge
> > into scripts. Chcon would require knowing some types in order to work. If the
> > types ever got changed, the script would break. Can anyone think of other
> > things we do not want to see in rpm scriplets?
> >
> > -Steve
> >
> >   
> calling semanage thusly:
> 
> semanage fcontext -a [any arguments here] /some/file
> 
> actually any semanage command except *possibly* login and user, and I'm 
> not sure they should be there either but someone may have an acceptable 
> scenerio.

If we disallow this then what is the recommended way to allow an
application to ship a labeling only policy? We need to allow
applications to, for example, label a library as textrel_shlib_t without
forcing them to ship a policy module.

What if we added the ability to specify the store by name (i.e.,
semanage -s targeted fcontext -a . . . .). I think it should be
acceptable to make assumptions about what a well know policy contains.
Getting them to use semanage in this way would fix other problems - like
relabeling - without introducing unnecessary policy modules.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
