Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA16050
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 18:27:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA02838
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 22:25:32 GMT
Received: from gw.oribium.com (h163n2fls32o973.telia.com [213.67.221.163])
	by jazzswing.ncsc.mil  with ESMTP id WAA02834
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 22:25:31 GMT
Subject: RE: newrules
From: Reino Wallin <reino@oribium.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: "'Russell Coker'" <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: 
	<72222DC86846D411ABD300A0C9EB08A10152436C@csoc-mail-box.csoconline.com>
References: 
	<72222DC86846D411ABD300A0C9EB08A10152436C@csoc-mail-box.csoconline.com>
Content-Type: text/plain
Date: 25 Apr 2002 23:31:05 +0200
Message-Id: <1019770266.27628.133.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tor 2002-04-25 klockan 19.59 skrev Westerman, Mark:
> on Thursday, April 25, 2002 12:44 PM, Russell Coker wrote: 
> 
> > > if a program does not need a permission such as lock, poll and ioctl
> > > don't grant that permission. As we develop more finer grained access
> > > rules program should only be granted the permission they need
> > > and nothing else. In security terms only grant what is need.
> > 
> > I understand the point, however with the current sample 
> > policy I'm working on it is already over 10K lines of code.  The 
> > more code the harder it is to audit...
> 
> 
> You have a very good point, and its only going to get worse. 
> We need a program to handle the policies. (To all those lurking
> on the list wanting something to do)
> 
> Are you going to include apol ?
> 
> Mark
> 
Both of you have very good points here. I totally agree with Mark to
only grant what is needed. However, it's getting complex and ugly to
maintain. Wouldn't it be good to add a few very useful, and very
finegrained, macros? I am thinking of macros like:

can_network_dns_only

to permit the domian to do networking, but only what is needed for name
resolution service. Somehow, I feel we will save time, and bring better
type enforcement files to the community with a set of new macros. I like
the new macros that was introduced in the current version of the example
policy and hope work is in progress to add new ones.

Reino





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
