Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KNWO7C005417
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 19:32:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3KNOgJK015969
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 23:24:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Richard Hally <rhally@mindspring.com>
Subject: Re: Experiences with selinux enabled targetted on Fedora Core 3
Date: Thu, 21 Apr 2005 09:27:06 +1000
Cc: "Fedora SELinux support list for users &amp; developers." <fedora-selinux-list@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
References: <20050221160539.6aba22bd.r.godzilla@comcast.net> <200504201621.46953.russell@coker.com.au> <42661F69.30102@mindspring.com>
In-Reply-To: <42661F69.30102@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504210927.10015.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 20 April 2005 19:22, Richard Hally <rhally@mindspring.com> wrote:
> >Using dontaudit rules for such things also gives correct behavior in
> >situations where relabelling will not.  As an example there is the
> > following rule:
> >dontaudit lvm_t file_t:dir search;
> >
> >Without this rule the lvm utilities when run before /var is mounted would
> >create the /var/lock directory on the mount-point.  This is not desired
> >functionality, the machine is in single-user mode at the time (so the lack
> > of locking is not a problem) and creating directories that later get
> > hidden by mounting a file system is not desirable.
> >
> >So far no-one has provided any reasons not to use dontaudit rules.
> >Accusations of kludging don't count as a reason.
> >
> >I don't consider file_t labelling for a mount point as "mislabelling". 
> > The mount point directory is expected to be hidden, so generally only
> > mount needs to access it.
>
> I for one consider the use of "dontaudit" to be unethical but that is
> just my opinion.

Why is it unethical to make software perform correctly even when it is not 
written to?

> Think about preventing someone's software from doing what was designed
> and implemented to do. Shouldn't you at least notify the
> developer/maintainer that there is a problem with their software? That

Yes, I do that.  I don't always notify them first.  The first priority is to 
get the policy fixed, if I don't do it then someone else may do it and do it 
badly (see this thread as an example).

> seems to be the correct thing to do in the open source community.
> If there is a actual security problem shouldn't there be some
> notification of the vulnerability as a minimum? If it is not an actual
> security vulnerability but perhaps a theoretical one, a proof of concept
> is usually appropriate.

If it's a functionality issue such as creating a directory /var/lock on the 
root file system when /var is a mount point then it's not such a big deal.

> If it is a violation of some generally accepted standard, isn't a
> bugzilla the right thing to do?

Yes.  Of course there are other considerations.  Sometimes I already have some 
open bug reports and don't feel inclined to make minor bug reports when more 
serious bugs are open.

> If some action by the software is "uninteresting" shouldn't it be
> allowed absent some reason that makes it in fact "interesting"?

Searching a directory of type file_t that is an empty mount point isn't 
interesting.  If however a directory that shouldn't be accessed by the 
program in question gets type file_t through file system corruption or other 
errors then we do not want to allow such access.

> I would like to hear what others think of  this "dontaudit considered
> harmful"  idea. I understand the use of dontaudit as a temporary
> expedient but other than that it seem that there should be more done
> about the situations where it is used at least in terms of notifying the
> developers/maintainers of the software involved.

Why don't you go through the policy, remove a bunch of dontaudit rules and see 
what happens.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
