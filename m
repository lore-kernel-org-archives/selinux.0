Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ID5TRb001007
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:05:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ID5QAT017307
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:05:26 GMT
Date: Tue, 18 May 2004 13:02:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518130244.GB24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 08:40:47AM -0400, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 06:40, Luke Kenneth Casson Leighton wrote:
> > from the list, below, i've removed me editing syslog as root without
> > doing newrole -r system_r :)
> 
> sysadm_r, not system_r.
 
 hey, given that i haven't allowed my useraccount to do newrole
 to _either_ of those...

> > 	allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
> > 	allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };
> > 
> > i mean, i see in domains/programs/xdm.te that there _are_
> > allow initrc_t xdm_rw_etc_t permissions for create (create_file_perms)
> > and also a comment that init scripts want to check for update
> > windowmanagerlist so they get getattr and read allowed.
> > 
> > ... so what's going on?? why am i getting these messages?
> 
> In the upstream policy, I see:
> $ grep 'allow initrc_t xdm_rw_etc_t' policy.conf
> allow initrc_t xdm_rw_etc_t:file { getattr read };
> 
> So initrc_t is presently only allowed to stat and read those files. 
> Now, there are other rules for xdm_t:
> $ grep 'allow xdm_t xdm_rw_etc_t' policy.conf
> allow xdm_t xdm_rw_etc_t:dir { read getattr lock search ioctl add_name remove_name write };
> allow xdm_t xdm_rw_etc_t:file { create ioctl read getattr lock write setattr append link unlink rename };
> 
> And the xdm.te source file does have a comment prior to the
> corresponding source statements that says that this is for wdm.
> But perhaps someone erred and submitted the wrong rules for wdm (we
> don't use it ourselves).

 okay, maybe this is a silly question.

 given the number of errors i am seeing, and given that they won't
 go away, perhaps there is some breakdown in communication between
 the rules being in the policy.conf file and their application to
 packages.

 for example, should i be doing a make relabel every time i add
 some new rules?

 should i force setfiles usage just like there is in
 /etc/dpkg/postinst.d/selinux?

 am i on the right track, here?

> > if i am using wdm (the patched version) is there anything i need to
> > do to get it to work / be accepted?
> 
> Don't know, as I've never used it.

 ah.  then i will try.... xdm, and see what happens.

 (wdm is the patched one from daniel walsh).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
