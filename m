From: Paul Moore <pmoore@redhat.com>
To: Waiman Long <waiman.long@hp.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: Follow-up on the lblnet-next tree
Date: Tue, 10 Sep 2013 10:14:46 -0400
Message-ID: <3166714.Qb6aJAv2jX@sifl>
In-Reply-To: <522E5B41.9090003@hp.com>
References: <3261672.EsmV8HmHXd@sifl> <522E5B41.9090003@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, September 09, 2013 07:35:29 PM Waiman Long wrote:
> On 07/23/2013 06:05 PM, Paul Moore wrote:
> > Just a quick follow-up to let you know that I've rebased the lblnet-next
> > tree to Linus' post -rc2 tree from earlier today.  I did a quick
> > build/boot/test cycle and everything looked sane to me, but additional
> > testing is always welcome.
> > 
> >   * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
> >   * http://git.infradead.org/users/pcmoore/lblnet-2.6_next
> 
> Just want to know if you are planning to push those patches into v3.12.

You and me both.

Your patches, as well as a number of others, should go in via Eric's SELinux 
tree, not my labeled networking tree; I was simply hosting the patches to get 
them some exposure in linux-next.  A few weeks back Eric merged the patches 
into his SELinux tree so I dropped them from lblnet-next to prevent conflicts.

Eric, push them patches up to James already.  It is absolutely ridiculous that 
we've got bug fixes that have missed *several* kernel releases because you 
aren't pushing fixes upstream.  This is *extremely* frustrating.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
