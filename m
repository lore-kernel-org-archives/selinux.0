Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00027
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:41:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA08884
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 16:39:32 GMT
Received: from scaup.mail.pas.earthlink.net (scaup.mail.pas.earthlink.net [207.217.120.49])
        by jazzband.ncsc.mil  with ESMTP id QAA08880 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 16:39:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Is make relabel suposed to be run from policy or or setfiles?
Date: Tue, 9 Jul 2002 11:41:06 -0500
References: <Pine.GSO.4.33.0207090723320.27193-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207090723320.27193-100000@raven>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200207091141.06258.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 09 July 2002 06:49, you wrote:
> On Mon, 8 Jul 2002, JW wrote:
> > /usr/local/selinux/bin/setfiles:  invalid context
> > system_u:object_r:inetd_var_log_t on line number 625
> > /usr/local/selinux/bin/setfiles:  invalid context
> > system_u:object_r:initrc_runlevel_t on line number 669
>
> The types listed above are not defined in the upstream .te files nor are
> they used in the upstream .fc files.  So I'll assume that you are using a
> customized policy other than the example policy.  

Actually, no, at the time I was reciving those error messages, I was indeed using the default ploicy files, policy11.
I am running on SuSE 8.0 Most of those errors whent away when I added Carstens's additional policy files for SuSE. 

> In any event, the error is
> quite simple:  you are using types in your .fc files that are not defined
> in your .te files.

Ok, that is the information I was looking for.


> > Just out of curiosity, why do you have to be root to do that? 
>
 > You can login as a normal user initially, but you need to su to root.
> When running on a SELinux kernel, you also need to be in sysadm_r.

Presumeably you mean su and newrole. I haven't tried it yet, I will later.

> Keep in mind that the SELinux access controls are orthogonal to the Linux
> access controls, and that both access controls must authorize an operation
> in order for it to be performed.

Ok. I was under the impression (from things I read and heard), that root was pretty much reduced to a normal user, and the sysadm_* user became, in effect, root. 
But I'm still reading on the subject, hopefully there's something written about this in the documentation.

Thank you.

	JW



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
