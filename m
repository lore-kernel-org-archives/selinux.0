Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QGj7Ok015196
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 12:45:07 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QGj5Yx010848
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 16:45:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2QGj4jT032386
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 12:45:04 -0400
Subject: Re: Elimination of disable_trans boolean ramifications
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46041166.8010102@redhat.com>
References: <46041166.8010102@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 12:43:25 -0400
Message-Id: <1174927405.12204.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 13:41 -0400, Daniel J Walsh wrote:
> I have removed the disable_trans booleans from Rawhide, and FC7 Test3.  
> I wanted to remove these booleans because they cause as many problems as 
> they solve.    If you turn off certain domains, it can change the 
> labeling on the system and cause other confined domains to blow up.
> 
> If you syslog_disable_trans, the devlog_t context is wrong and any 
> confined app that tries to syslog will no longer work.
> 
> The best thing to do when confronted with an AVC would be to figure out 
> if this is expected behavior, if yes then report it as a bug to upstream 
> or to the distribution and create a loadable policy module that handles 
> the problem.
> 
> If there are so many problems or a user just does not want to deal with 
> it I figured we could just load a policy that sets the domain as an 
> unconfined_domain.
> 
> If you wanted to run samba as an unconfined domain  you would build a 
> policy module
> 
> policy_module(mysamba, 1.0)
> 
> require {
>         type smbd_t;
> }
> 
> unconfined_domain(smbd_t)
> 
> 

So - I like this idea from a technical point-of-view. The only concern
is that users are used to looking for a booleans for this type of thing.
There is some hope that they would discover the changed booleans poking
around a gui tool or using g/setsebool. I don't think most users would
never think to create a module to make a domain unconfined. Plus, the
directions on how to do this go from a single command to several.

I've heard concern that the number of booleans is growing too large. I
would suggest that if that is your motivation for avoiding booleans that
we find a way to organize them instead.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
