Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA17243
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 09:44:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA00935
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 13:43:08 GMT
Received: from lyta.coker.com.au (n136.ols.wavesec.net [209.151.19.136])
        by jazzband.ncsc.mil  with ESMTP id NAA00929 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 13:43:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Oren Abe-P27525 <Abe.Oren@gd-decisionsystems.com>
Subject: Re: SE Linux loading procedure.
Date: Tue, 25 Jun 2002 23:44:56 -0400
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206240944170.10386-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206240944170.10386-100000@raven>
MIME-Version: 1.0
Message-Id: <20020626134424.D269F7C0E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Jun 2002 09:45, Stephen Smalley wrote:
> On Fri, 21 Jun 2002, Oren Abe-P27525 wrote:
> > Do you (or anybody) have a flow chart(s)
> > describe the SE Linux loading sequence.
> >
> > Something like step-by-step of the main
> > modules and procedures that loads into the
> > memory during the boot process ?
>
> I'm not aware of any such flow chart for SELinux.  But keep in mind that
> the SELinux kernel is merely a modified form of the Linux kernel
> (Linux+the LSM kernel patch+the SELinux kernel module).

I think that perhaps they want a list of the differences between SE Linux and 
a regular Linux kernel.

Basically as part of the proceedure of mounting the root file system or doing 
a pivot_root() operation the new policy file is loaded from 
/etc/security/selinux/ .

After that is loaded if it's the first load of a SE policy then it'll apply 
SIDs to kernel threads etc.

After that is done then the PSID mappings for the file system are 
re-evaluated to avoid the initrd problems (in the latest patches anyway).

Then when the kernel runs init it's subject to the regular 
domain_auto_trans() rules and things go in a normal fashion from there.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
