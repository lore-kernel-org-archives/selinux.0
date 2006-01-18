Message-ID: <43CE9152.1030708@cornell.edu>
Date: Wed, 18 Jan 2006 12:04:50 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>	 <43CE8AB3.1070103@cornell.edu> <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Policy server avoids the need for the client program to pass DAC checks
> on the module store, but a) some kind of checking will certainly be
> applied by the policy server on client requests, and b) use of policy
> server will not be mandatory at least in the short term (even after it
> is merged).
>   
Is there a problem with making some of those store files world-readable, 
and making changes to allow lock files to be written by ordinary users 
somehow. I don't understand why the selinux copy if the data is 
readable, but the semanage copy is not, if they contain the same thing.
> Also, the current usage pattern for file_contexts and seusers is that
> libselinux reads the installed files for runtime operation rather than
> getting the information from libsemanage, so I'm not sure why chcat -L
> -l wouldn't just read the installed seusers file too (preferably via
> libselinux function).  The installed files already have DAC modes that
> allow user read access, subject only to policy restrictions.
>   
Libsemanage has an interface for that kind of thing already - why can't 
that be used? I'm starting to get confused about the difference between 
all those libraries again. If libselinux is to be used on runtime, and 
libsemanage on persistent policy, then how do you explain the need for 
active booleans backend in libsemanage?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
