Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29L3Ckb010357
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 16:03:12 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o29L3cKP010955
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 21:03:39 GMT
Message-ID: <4B96B78A.4020801@redhat.com>
Date: Tue, 09 Mar 2010 16:03:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] what to do: libsemanage.get_home_dirs:
References: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
In-Reply-To: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/09/2010 01:01 PM, Justin Mattock wrote:
> with the latest policy on open suse 11.2
> I'm seeing this after building the policy:
> libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its
> parent directory conflicts with a file context already specified in
> the policy.  This usually indicates an incorrectly defined system
> account.  If it is a system account please make sure its uid is less
> than 1000 or its login shell is /sbin/nologin.
>
> with using an older policy on this system, I never saw this.
>
> what to do?
>
>    
/var/lib/nobody record in /etc/passwd needs to have a shell of 
/bin/false or /sbin/nologin or a UID < 500.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
