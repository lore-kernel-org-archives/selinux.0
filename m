Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2AFjVYx011219
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 10:45:33 -0500
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2AFjxI8029581
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 15:45:59 GMT
Received: by pwj3 with SMTP id 3so146691pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 07:45:31 -0800 (PST)
Subject: RE: [refpolicy] what to do: libsemanage.get_home_dirs:
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E45FB4E0@EUSAACMS0703.eamcs.ericsson.se>
References: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E45FB4E0@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Mar 2010 07:45:32 -0800
Message-ID: <1268235932.3733.18.camel@linux-qbdl.site>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-10 at 10:35 -0500, Alan Rouse wrote:
> Justin Mattock wrote:
> > with the latest policy on open suse 11.2 I'm seeing this after building the policy:
> > libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent directory conflicts with a 
> > file context already specified in the policy.  This usually indicates an incorrectly defined system 
> > account.  If it is a system account please make sure its uid is less than 1000 or its login shell is 
> > /sbin/nologin.
> >
> > with using an older policy on this system, I never saw this.
> >
> > what to do?
> 
> usermod -s /sbin/nologin nobody


just read the other post..
I'll give this a try and see.

Thanks.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
