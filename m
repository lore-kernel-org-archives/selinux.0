Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25597
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 13:12:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA21610
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 17:11:07 GMT
Received: from austin.bmh.com (austin.bmh.com [216.54.77.38])
        by jazzband.ncsc.mil  with ESMTP id RAA21606 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 17:11:07 GMT
Received: (from root@localhost)
	by austin.bmh.com (8.11.6/8.11.2) id g6CHAK310987
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 13:10:20 -0400
From: Natr Brazell <brazell@bmh.com>
Message-ID: <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com>
Date: Fri, 12 Jul 2002 13:10:19 -0400 (EDT)
Subject: =?iso-8859-1?Q?Re:_revising_the_su_decision?=
To: jabiru_croc@yahoo.com
In-Reply-To: <20020712111941.30466.qmail@web40009.mail.yahoo.com>
References: <20020712111941.30466.qmail@web40009.mail.yahoo.com>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just joined this mailing list so perhaps my question is already answered  
however...

...  I work in an R&D environment with machines that are usually up and 
configured for the duration of the experiment and then scrapped and 
reloaded  for the next experiment.  Usually a time span of two months at 
the most.  While in the experiment there are several tasks that must be 
done consistently across all of my machines such as verifying time sync 
with ntp etc.  In the past we used rsh (no really) with .rhosts files and 
wrote scripts to push from a single entry point to manage all the machines 
at the same time.  We also use this configuration to push new software 
builds (every morning) across all machines.  When I say all machines I am 
addressing 30-65 or more PCs.  Using SELINUX is a requirement at the 
facility I am at even though no one knows anything about selinux expect 
how to spell it so I guess I am the expert.  (Haven't got the T-Shirt yet) 
but I have got people looking at my configuration as a starting point for 
future projects.  Now to my question...

...  What is this lists proposal for how to manage and push to multiple 
machines quickly and securely based on the above comments?

Nate Brazell
BMH Associates, Inc
Leaders in Modeling and Simulation
System Administrator
> Mr. Coker,
> 
> --- Russell Coker <russell@coker.com.au> wrote:
>> Up until now the su program was not modified, so changing to a
>> different UID  was a separate and independant operation from changing
>> domain via newrole.
>> 
>> However now that the sshd policy has been set to default to not allow
>> logins  as sysadm_r:sysadm_t this causes some inconveniance.  I have
>> to ssh in to my  server as a non-root account with a non-sysadm_r
>> context.  Then I have to use
> 
>> newrole to change to sysadm_r (entering the password), and then I have
>> to su  to the root account (entering the root password).
>> 
>> This requires entering the password two times (or three if not using
>> ssh  authorized_keys).
>> 
>> This is excessively painful, and I think that to make SE Linux more
>> usable we
> 
>> need to address this issue, possibly by changing su to allow it to
>> change  roles too.
>> 
>> What do you think?
> 
>           Why do you have to change your role to sysadm_r before su'ing
>           to
> root? I was under the impression that becoming uid 0 by either logging
> in or su'ing was sufficient.....
> 
> Brad
> 
> 
> =====
> Brad Chapman
> 
> Permanent e-mails: kakadu_croc@yahoo.com
> 		   jabiru_croc@yahoo.com
> 		   tanami_croc@devel.lbsd.net
> 
> __________________________________________________
> Do You Yahoo!?
> Sign up for SBC Yahoo! Dial - First Month Free
> http://sbc.yahoo.com
> 
> --
> You have received this message because you are subscribed to the
> selinux list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
