Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA21590
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 00:43:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA04557
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 04:43:13 GMT
Received: from centauri.ee.ucla.edu (centauri.ee.ucla.edu [128.97.92.179])
	by jazzswing.ncsc.mil  with ESMTP id EAA04553
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 04:43:12 GMT
Date: Thu, 11 Jul 2002 21:43:32 -0700 (PDT)
From: Simon Han <simonhan@ee.ucla.edu>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
In-Reply-To: <20020712020642.D58E442F2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.10.10207112141001.22695-100000@centauri.ee.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russell,
	I was about to pose the same comment on newrole/su.  :)  I guess
there was some idea behine creating newrole as independent program instead
of extending su.  Could someone share the idea?

Thanks,
Simon

On Fri, 12 Jul 2002, Russell Coker wrote:

> Up until now the su program was not modified, so changing to a different UID 
> was a separate and independant operation from changing domain via newrole.
> 
> However now that the sshd policy has been set to default to not allow logins 
> as sysadm_r:sysadm_t this causes some inconveniance.  I have to ssh in to my 
> server as a non-root account with a non-sysadm_r context.  Then I have to use 
> newrole to change to sysadm_r (entering the password), and then I have to su 
> to the root account (entering the root password).
> 
> This requires entering the password two times (or three if not using ssh 
> authorized_keys).
> 
> This is excessively painful, and I think that to make SE Linux more usable we 
> need to address this issue, possibly by changing su to allow it to change 
> roles too.
> 
> What do you think?
> 
> -- 
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in your
> address-book so that WHEN you get a virus it won't use my address in the
> >From field.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
