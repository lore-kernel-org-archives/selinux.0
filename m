Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA07418
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 23:09:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA21349
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 03:09:37 GMT
Received: from web14311.mail.yahoo.com (web14311.mail.yahoo.com [216.136.224.61])
	by jazzswing.ncsc.mil  with SMTP id DAA21345
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 03:09:36 GMT
Message-ID: <20020529030941.3019.qmail@web14311.mail.yahoo.com>
Date: Wed, 29 May 2002 04:09:41 +0100 (BST)
From: =?iso-8859-1?q?vishwakarma=20singh?= <vsingh014@yahoo.com>
Subject: Re: setuid problem
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0205281138510.1315-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I like that all the setuid programs are executed even
if  new sid  assigned to them fails to comply to the
rules of the policy (in this case program will be 
prevented  from executing ) . that is , i want to run
all setuid programs  just like  simple linux . than
what are the changes i should bring in ....

thanx
vishwakarma singh

 --- Stephen Smalley <sds@tislabs.com> wrote: > 
> On Tue, 28 May 2002, [iso-8859-1] vishwakarma singh
> wrote:
> 
> >  If i am not wrong than setuid does not work in
> > selinux if they donot comply to the rules of
> policy
> > configuration . but since many programs and
> utilities
> > in normal linux uses setuid , i want to reenable
> it .
> > have anybody any idea , how to reenable it ?please
> > give details.
> > thanx
> 
> SElinux doesn't disable setuid.  It does perform a
> parallel check to the
> existing CAP_SETUID capability checks, but setuid
> program execution only
> requires CAP_SETUID under special conditions
> (process tracing, shared
> state via clone).  If you are encountering a setuid
> capability denial from
> SELinux, you can grant that permission to the
> appropriate domain (or
> define a new domain, as appropriate).
> 
> The SELinux access controls are orthogonal to the
> Linux access controls,
> and do not depend on the Linux identity attributes. 
> Please read the
> Configuring the SELinux Policy report, particularly
> the security model
> section.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 
> --
> You have received this message because you are
> subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message. 

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
