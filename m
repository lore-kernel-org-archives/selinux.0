Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB1KmqNm018591
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 15:48:52 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB1Kl9IW003356
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 20:47:09 GMT
Message-ID: <457094DA.4080704@hp.com>
Date: Fri, 01 Dec 2006 15:47:22 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <1165003691.18588.103.camel@code.and.org>
In-Reply-To: <1165003691.18588.103.camel@code.and.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
>  As some of you know, there's an open BZ about the fact that in a
> strict/MLS environment useradd doesn't create the user's homedir with
> the correct context[1].
>  The problem is that matchpathcon() needs semanage to have run, so we
> know what SELinux user the unix user is associated with, but that runs
> separately and after useradd. The four obvious solutions are:
> 
> 1. Have an option for useradd to call semanage to add the selinux user,
> and then do the restorecon.

I think useradd should be able to either create the selinux user or map the
linux user to an existing selinux user.  Right now you can't create an
selinux user without a linux login but I think I ought to be able to create
the selinux users separate and them map one or more linux login to each one,
or have useradd create a unique linux user for me if I choose.  And if I
don't choose, the linux user should end up with the correct home directory
based on the default selinux user.
> 
> 2. Have semanage do the equivalent of a restorecon when doing an
> add/modify (or just add) of SELinux user information.

If the semanage is done after the useradd (could be weeks after), the
user could have files that live outside the home directory (I think
Dan pointed this out to me) so what files and directories would you
run restorecon on?
> 
> 3. Have some kind of wrapper that does:
> 	i. useradd
> 	ii. semanage
> 	iii. restorecon

I don't like the wrapper idea because if we can do it in a wrapper,
we can do it in useradd.
> 
> 4. Document that you need to call the list of programs in #3.

I think we need to document that anytime semanage is used one
might need to run restorecon.  There's nothing in the semanage
manpage about that, for example.
> 
>  Does anyone have comments on which of the above they like/hate?
> 
> 
> [1] http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=217441
> 

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
