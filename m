Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o39CWdG7013692
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 08:32:39 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o39CXRUl016528
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 12:33:27 GMT
Received: by vws3 with SMTP id 3so504280vws.12
        for <selinux@tycho.nsa.gov>; Fri, 09 Apr 2010 05:32:37 -0700 (PDT)
Subject: Re: Cannot not open session
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E46493A4@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E46493A4@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Apr 2010 08:38:42 -0400
Message-ID: <1270816722.2650.7.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-04-09 at 08:16 -0400, Alan Rouse wrote:
> Two questions:
> 
> 1. I'm working with selinux in opensuse.  With selinux in enforcing mode, su is not working.  For example, suppose root tries to su to an unprivileged user.  I'm asked if I would like to enter a security context [N].  If I say no, it responds "su: cannot not open session:  Authentication failure".   With selinux in permissive mode, it works... and no avc messages are logged.   
> 
> Any idea what I have done wrong?
> 
> 2.  When I try to su to an unprivileged user, and it asks if I would like to enter a security context, suppose I say yes.  It asks for a role, and I enter 'user_r'.  then it asks for a level.  What kind of answer does it expect here?  Nothing I've tried works....

Remove pam_selinux from /etc/pam.d/su.

Early Fedora and RHEL-4 put pam_selinux in /etc/pam.d/su in an effort to
automatically change contexts upon user identity changes.  This proved
to be a mistake in practice (and a deviation from the original SELinux
approach), and was subsequently removed in later Fedora and RHEL-5.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
