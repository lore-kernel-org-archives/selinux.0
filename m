Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3NDYZgA022541
	for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2005 09:34:35 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3NDQRGJ004745
	for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2005 13:26:28 GMT
Subject: Re: [ PATCH ] Cumulative patch - various fixes,
	untrusted_content_t, mozilla, gnome types
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200504172346.39313.russell@coker.com.au>
References: <1113445869.6139.52.camel@cobra.ivg2.net>
	 <200504172346.39313.russell@coker.com.au>
Content-Type: text/plain
Date: Sat, 23 Apr 2005 09:29:04 -0400
Message-Id: <1114262945.4365.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been busy with school, and no time to work on this - 
filed bugs to keep track of things:

Here's new patch version, with policy attempt for GConf:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155800

Here are related problems. I am very interested in the solution
for the first one, at least.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155799
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155798
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155796


>> 1) Introduces new type - ROLE_untrusted_content_t.
>> This will be the "downloads" folder type that I proposed earlier.
>> I started a discussion on the Gnome Usability list about further
>> separation, but so far it doesn't seem to be making progress.

> This is a difficult area that requires a lot of thought and work if we are to 
> have a chance to get it right.  Let's leave this until after we get some of 
> the base stuff done.

Can you list some of the things that need to be done?
I thought it would be sufficient to create a default downloads folder
for the user that is sufficiently visible (integrated w/ desktop
environments)

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
