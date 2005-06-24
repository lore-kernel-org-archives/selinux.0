Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OIVvgA009102
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:31:58 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OIVM2B001482
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:31:22 GMT
Subject: Re: Alternative user management approach
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1119636615.31852.37.camel@celtics.boston.redhat.com>
References: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
	 <1119636615.31852.37.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:29:27 -0400
Message-Id: <1119637767.31852.48.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 14:10 -0400, Ivan Gyurdiev wrote:
> > 1) Reloading the kernel policy on user change just seems . . . wrong.
> > 2) Having the users in the kernel can be problematic for large numbers of users.
> > 3) These problems get much worse if we are talking about large, distributed user
> > databases. Are sites with 10,000 users going to force a policy reload on every
> > machine every time a user is added? Are all 10,000 users going to be stored in
> > the kernel?
> 
> > Normal Linux users are then mapped to user roles by username or group membership
> > (this should be done by libselinux and not involve the kernel). For example, if
> > the primary group of the user is wheel then they could be assigned to staff,
> > root assigned to sysadm, and everyone else to normal. This makes the addition of
> > a user roughly equivalent to adding roles - something done by a policy developer
> > that does not need to be done as part of normal system administration.
> 
> So you're taking away the sysadmin's ability to define fine-grained
> role membership, and replace it with giving the sysadmin the ability
> to define coarse-grained "role class" membership, and each "role class"
> is determined by the policy developer...hmm 
> 
> Not sure I like this...although I see the scalability concern.

Also, what's to stop you from implementing this with the current
mechanism?

The "role class" could be the SElinux user. 

Then useradd could be changed to only reload policy if you're adding
new SElinux users ("role classes"). Better - useradd would stay
unchanged, and a new application would be written called
classadd or something.

Then you'd still need to map users to their SELinux users/classes
though..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
