Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49E2PrK016098
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:02:25 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49E2LEk018030
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 14:02:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: pam_namespace
Date: Wed, 10 May 2006 00:02:24 +1000
Cc: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>
References: <200605051623.25533.russell@coker.com.au> <445F4B38.9080808@us.ibm.com> <200605092257.59047.russell@coker.com.au>
In-Reply-To: <200605092257.59047.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605100002.28660.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 09 May 2006 22:57, Russell Coker <russell@coker.com.au> wrote:
> > >Having "both" and "both_no_mcs" is confusing.  Maybe it would be best to
> > >have "user" and "context" as separate items to replace "both" and then
> > >support a fourth option as "range", "high" or "low".
> >
> > I am not sure I understand. We have "user", "context" and "both", where
> > type in the context can be controlled through type-member policy rules
> > and the mls range is inherited from the process. Can you give an example
> > of what context the instance would have with "range" or "high" or "low"?
>
> My idea is that the range, high, and low values would be candidates for the
> file name.
[...]
> Probably the easiest thing to do is to default to including the entire
> security context of the process in the directory name.

One thing that I consider to be necessary is to allow the administrator to 
determine in which situations the PI directories should be shared.  Using a 
default that has the full context including range will work, but many admins 
will want finer grained control.

For example if the aim is to separate MLS ranges such that file names can not 
be used to accidentally reveal secret data then there may not be a need for 
separate Unix UIDs to have different directories, and directory names could 
be based on range alone.

Another possibility is when running the strict policy a user might have 
multiple roles but not want to have a different copy of /tmp for each one.  
For example if I scp a file to the /tmp directory used for role A then after 
running newrole to change to role B I will still want to see the file in 
question (assuming of course that the policy allows access to it).

Then for MCS the issue of whether it's most desirable to base instance 
directory names on the high or the low level is something that we probably 
won't ever get an agreement on.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
