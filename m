Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: sysadm_devpts_t access for daemons
Date: Fri, 13 Sep 2002 18:08:35 +0200
MIME-Version: 1.0
Message-Id: <200209131808.35797.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've found that the recent versions of slapd and named need to have write 
access to their controlling terminal to correctly start.  I think that they 
didn't need the access before so I guess there's been some change.

It seems to me that an increasing number of daemons is needing such access.  
So we are not giving any option for reporting startup errors for some 
daemons, while giving inappropriate terminal access to others.

I think that one of the options I suggested regarding creating a special 
pseudo-tty for daemon start is necessary.

At the moment I think that having the code in run_initis the best solution.  I 
will start coding this regardless of objections unless someone has a better 
idea.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
