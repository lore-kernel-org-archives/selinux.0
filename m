Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27088
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:24:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA10607
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:24:27 GMT
Received: from web40208.mail.yahoo.com (web40208.mail.yahoo.com [66.218.78.69])
	by jazzswing.ncsc.mil  with SMTP id PAA10603
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:24:26 GMT
Message-ID: <20020627152451.37794.qmail@web40208.mail.yahoo.com>
Date: Thu, 27 Jun 2002 08:24:51 -0700 (PDT)
From: Michael Nyika <nyix@yahoo.com>
Subject: RE: System.te ?
To: Stephen Smalley <sds@tislabs.com>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0206271116090.11979-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

true: but what about "new" system processes, or
rather, those that do NOT appear in
/policy/domains/programs ? I'm thinking that if there
is an undefined process, it should take on default
behaviour found in a file i mentioned earlier?

--- Stephen Smalley <sds@tislabs.com> wrote:
> 
> On Thu, 27 Jun 2002, Michael Nyika wrote:
> 
> > If Sysadm_t and user_t are domains whose
> definitions
> > exist in admin.te and user.te in policy/domain,
> then
> > why isnt there ( i presume) a file called
> system.te to
> > define default behaviour for the system_t domain
> for
> > system processes, in the same directory (or other
> > dir)?
> 
> There are a number of domains defined for system
> processes, each limited
> to the appropriate set of permissions.  These
> domains can be found under
> policy/domains/program.  There used to be a separate
> policy/domains/system
> subdirectory, but it was folded with the program
> directory because the
> distinction wasn't helpful.  Many programs are run
> both as system
> processes and as administrator commands, so there
> was ambiguity as to
> where many domains belonged.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
