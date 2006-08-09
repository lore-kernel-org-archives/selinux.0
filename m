Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k79DK8C9000728
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 09:20:08 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k79DJncx025415
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 13:19:50 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k79DK4Vx019202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 09:20:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k79DJs9v099904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 07:19:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k79DJpjD028804
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 07:19:51 -0600
Subject: re: id -Z subsumed by secon?
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Meyering <meyering@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44D8DED5.4040304@redhat.com>
References: <44D8DED5.4040304@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 09:19:43 -0400
Message-Id: <1155129583.19094.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-08 at 14:58 -0400, Daniel J Walsh wrote:
> >
> >
> > James Antill <james.antill@redhat.com> wrote:
> >   
> >> >  No, what Steven was saying is that the label for execcon will be reset
> >> > on exec (after doing it's thing). To see this visually use "secon
> >> > --self-exec" instead of id.
> >> >
> >> > % secon
> >> > user: user_u
> >>     
> > ...
> >
> > Thanks for the example.
> >
> > By the way, doesn't secon make id's -Z option unnecessary?
> > I'm planning not to include the 'id -Z' patches upstream,
> > Instead, runcon (with neither CONTEXT nor COMMAND) will
> > print the current security context -- to be analogous to how nice(1)
> > works if you don't give it a command.
> >
> > Any objection?
> >
> >
> >   
> Yes I would like to maintain the idea of "-Z" being the way to view 
> contexts.  This makes it easy for
> a user to figure out how to see what context is being used.  ls -Z, ps 
> -Z, netstat -Z ...
> 
> 

We are also using "id -Z" in our evaluation tests and would like to
keep the option.

-Janak

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
