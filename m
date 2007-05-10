Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4AFnMBY001073
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:49:22 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4AFnLaY003829
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 15:49:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4AFnKus028451
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:49:20 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4AFnK48027677
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:49:20 -0400
Subject: Re: Making Fedora a contributer friendly environment
From: Karl MacMillan <kmacmill@redhat.com>
To: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200705101650.50233.opensource@till.name>
References: <1178291788.2702.10.camel@vorpal.macdev.com>
	 <200705091725.58679.opensource@till.name>
	 <1178805305.17816.29.camel@localhost.localdomain>
	 <200705101650.50233.opensource@till.name>
Content-Type: text/plain
Date: Thu, 10 May 2007 11:49:20 -0400
Message-Id: <1178812160.24335.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[CC'd the selinux development list so that the developers are aware of
these issues]

On Thu, 2007-05-10 at 16:50 +0200, Till Maas wrote:
> On Do Mai 10 2007, Karl MacMillan wrote:
> 
> > When selinux is turned on again a full relabel of the filesystem is done
> > to correct these problems. If the custom file context wasn't added to
> > the database of file contexts (via a module or semanage) the file is set
> > to the default label.
> 
> So will chcon in a scriptlet work, when an rpm is installed while selinux is 
> not active?
> 

Unfortunately it won't - does semanage / semodule work in this instance
(it probably should so that users can turn selinux back on after
disabling and doing package management).

> > Not sure what you mean - you should be able to run semanage in a post.
> > Perhaps you should also need to do chcon (as opposed to restorecon)
> > because the command may not have run before the file was created.
> 
> When I tested semanage, the problem occured, how to update the labels with 
> semanage. E.g. when the regex is changed that desribes, which files should be 
> labeled in a certain way. And when one wants to remove the old labels when 
> uninstalling the package. E.g
> 
> version 1 of the package:
> 
> %post
> semanage add RULE1
> %postun
> semanage remove RULE1
> 
> As far as I understand rpm, when updating the release of version 1, first 
> semanage add RULE1 from release two runs from %post and then
> semanage remove RULE1 from release one. This effectivly removes the rule from 
> the /etc/selinux, because identical rules seem not be added more than once 
> to /etc/selinux. When I restrict the %postun only to complete removals of the 
> package,

Which seems like the right answer.

>  than when one changes the RULES, e.g. in a version 2:
> 
> %post 
> semanage add RULE2
> %postun
> semanage remove RULE2
> 
> then RULE1 will not be removed (it is not the final remove). Then every 
> release has to include "semanage remove RULE1" in "%post" maybe forever. I 
> hope you understand the problem I try to describe, because I did not really 
> use the correct selinux-terms.
> 

Seems like there are two cases:

1) The context changes but the file spec stays the same - blindly adding
should always work here (it will overwrite the old file context).

2) The file spec changes (doesn't matter if the context changes) - you
will have to carry around the removal in the post forever.

> I would be happy, if I am wrong with this. But if this problem is not solvable 
> with semanage, imho semanage is not a good way to add selinux support to a 
> package.
> 

Maybe - we can make changes as necessary to make it usable.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
