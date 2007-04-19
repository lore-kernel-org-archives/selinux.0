Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JJHRRg012918
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:17:27 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JJHQrk002500
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 19:17:26 GMT
Subject: Re: Samba fixes
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4627B5C0.7070305@us.ibm.com>
References: <46277C78.8090200@redhat.com> <46278792.90602@us.ibm.com>
	 <4627AC90.2050502@redhat.com>  <4627B5C0.7070305@us.ibm.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 15:11:42 -0400
Message-Id: <1177009902.21732.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 13:32 -0500, Michael C Thompson wrote:
> Daniel J Walsh wrote:
> > Michael C Thompson wrote:
> >> Daniel J Walsh wrote:
> >>> I have been working heavily with the samba team here to get selinux 
> >>> policy working well with samba.
> >>>
> >>>
> >>> Most controversial part is
> >>> samba_unconfined_script_exec_t
> >>>
> >>> Which is a directory that administrators can put random scripts into 
> >>> and allow samba to execute.
> >>
> >> So, three questions:
> >> 1) What user would be executing these scripts? The 'samba' user?
> > Samba Developers say:
> > 
> > Either the authenticated user or root, it really depends on the script.
> > 
> > For example, a "preexec" script is run before the share is accessed as
> > the user that authenticated to samba (or the forced user as per "force
> > user" parameter), while a "root preexec" script would always be run as
> > root. Other scripts always run as root or always as auth user depending
> > on the action to be performed (ie add user scripts always run as root,
> > while print related stuff should always run as user).
> > 
> >>
> >> 2) What is the intention of such functionality? To have samba be able 
> >> to run file management tools or something?
> >> 3) Is supporting this functionality even a good idea?
> > As opposed to setenforce 0/or samba_disable_trans?
> 
> That might be better than running with a false sense of security :) Even 
> though this is an "administrative restricted" set of scripts, if an 
> attacker could place malicious scripts in the directory, then permitting 
> samba to exec them as root could be an avenue of attack.
> 

Well, setenforce 0 means that SELinux is definitely not improving
security while allowing this is just a potential problem.

> 
> My original point was simply that if its so controversial, that might 
> beg the question "is offering this functionality a good idea, in the 
> first place?".
> 

Trying to make security decisions for people makes them just disable
SELinux. I don't mean to aim this directly at you, but we should treat
the users of SELinux as intelligent and capable of making their own risk
decisions.

As long as it is possible to use this feature in at least one way that
isn't false security then it should be available (e.g., by tightly
controlling how the scripts could be added). Clueless users will allow
this one way or another and I think it is preferable to have them leave
SELinux on than disable it.

Along those lines:

* Can samba write to this directory (making it essentially unconfined)?
* Is the directory separately typed so that other domains can be
controlled?
* Is there a fairly easy way to create a confined script type (like with
Apache)? That would offer a more secure alternative?
* Can the running of the scripts be disabled with a boolean?

Karl

> Mike
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
