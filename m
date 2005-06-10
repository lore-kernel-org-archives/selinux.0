Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AGAmgA020010
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 12:10:48 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AG3BfM029751
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 16:03:11 GMT
Subject: Re: Restorecon script
From: Joshua Brindle <jbrindle@tresys.com>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <1118370767.30464.16.camel@localhost.localdomain>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <42A8F6C1.20106@tresys.com>
	 <1118370767.30464.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 12:05:42 -0400
Message-Id: <1118419542.366.8.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 22:32 -0400, Ivan Gyurdiev wrote:
> > What problem is this solving?
> 
> It is solving the problem of labeling things properly in /tmp and /home
> (according to recent policy changes,

relabeling at policy modification time is much better than automated
relabeling when a user logs in

>  which I've been working on).
> This cannot be accomplished by either inheriting the parent's context,
> (because it's not the same), or by file_type_auto_trans, because of
> ambiguity - same type change rule matches multiple target types.
> You can see details of what I mean in the thread "file_type_auto_trans
> is not sufficient" on selinux@tycho.nsa.gov.
> 
> It can be solved by setfscreate code in the application, but
> that's worse - intrusive code in multiple applications.
> 

it can also be solved by properly structuring directories, either by
application configuration or if necessary modifying the application in a
much less intrusive way (this was mentioned on that thread I believe)

> Creating folders ahead of time is the most acceptable solution so far.
> I'm not sure how exactly this should be done, but some sort of simple 
> script like this is one possibility. 
> 

scripts that install stuff to skel maybe should be responsible for
adding them to user dirs and labeling properly. This would be a trusted
app (rpm or whatever) instead of a user shell script

> >  In general relabeling isn't something that 
> > should be done without careful attention, especially when automated. 
> 
> I agree.
> 
> > User home directories shouldn't have incorrect labels is care is taken 
> > (ie, skel contains the directories you'd be relabeling anyway and they 
> > are labeled correctly when the user is added).
> 
> skel is populated when installing individual applications, and 
> that doesn't fix the labels for existing users, only for newly 
> created users. Also, that doesn't address /tmp.
> ==============

response above 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
