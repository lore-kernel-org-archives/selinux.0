Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29MTOKi015441
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 17:29:24 -0500
Received: from fg-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o29MT4KS006206
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 22:29:05 GMT
Received: by fg-out-1718.google.com with SMTP id d23so443973fga.12
        for <selinux@tycho.nsa.gov>; Tue, 09 Mar 2010 14:29:22 -0800 (PST)
Subject: Re: [refpolicy] what to do: libsemanage.get_home_dirs:
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B96B78A.4020801@redhat.com>
References: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
	 <4B96B78A.4020801@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Mar 2010 14:29:19 -0800
Message-ID: <1268173759.4289.2.camel@linux-qbdl.site>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-03-09 at 16:03 -0500, Daniel J Walsh wrote:
> On 03/09/2010 01:01 PM, Justin Mattock wrote:
> > with the latest policy on open suse 11.2
> > I'm seeing this after building the policy:
> > libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its
> > parent directory conflicts with a file context already specified in
> > the policy.  This usually indicates an incorrectly defined system
> > account.  If it is a system account please make sure its uid is less
> > than 1000 or its login shell is /sbin/nologin.
> >
> > with using an older policy on this system, I never saw this.
> >
> > what to do?
> >
> >    
> /var/lib/nobody record in /etc/passwd needs to have a shell of 
> /bin/false or /sbin/nologin or a UID < 500.
> 
> 

cool thanks..
I'll google a bit before making any changes.
usermod -u 500 login seems to be it,
but I also seen things in the user/group gui
menu which might be safer to try.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
