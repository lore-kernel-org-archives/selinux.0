Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4EIc1YU011471
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 14:38:01 -0400
Received: from yw-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4EIbwVe028316
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 18:37:59 GMT
Received: by yw-out-1718.google.com with SMTP id 9so787209ywk.84
        for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 11:38:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd18b0c30905140951x72877a78g67ad0a893b210278@mail.gmail.com>
References: <dd18b0c30905140951x72877a78g67ad0a893b210278@mail.gmail.com>
Date: Thu, 14 May 2009 11:38:00 -0700
Message-ID: <dd18b0c30905141138l5e530487o18a6938357b84ee8@mail.gmail.com>
Subject: Re: make: *** No rule to make target with latest svn
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 14, 2009 at 9:51 AM, Justin Mattock <justinmattock@gmail.com> wrote:
> I've seen this with earlier versions of refpolicy(when making mcs)
>
> Validating mcs  file_contexts.
> /sbin/setfiles -q -c /etc/selinux/mcs/policy/policy.22 file_contexts
> Installing file_contexts.
> install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
> install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
> python -E support/genhomedircon -d /etc/selinux -t mcs
> The user "staff_u" is not present in the passwd file, skipping...
> The user "sysadm_u" is not present in the passwd file, skipping...
> The user "unconfined_u" is not present in the passwd file, skipping...
> make: *** No rule to make target
> `/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
> Stop.
>
> when making the policy
> I have the policy in my home directory
> usually do a chown -R name:name refpolicy
> (before building)
> then:
> make conf
> make policy
> sudo make install
>
> do I need to build this thing always as root?
>
> --
> Justin P. Mattock
>

my bad, I guess you can't
compile a new refpolicy as mcs
first(using standard first compiled
cleanly)

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
