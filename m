Message-ID: <4267A304.4070106@redhat.com>
Date: Thu, 21 Apr 2005 08:56:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Richard Hally <rhally@mindspring.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [Fwd: Re: Experiences with selinux enabled targetted on Fedora
 Core 3]
References: <42677591.8020703@mindspring.com> <1114086578.4054.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1114086578.4054.69.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If someone is willing to read through the dontaudits and find the ones 
that are legitimate bugs versus,
Access to /etc/shaodow or daemons wanting to talk to the terminal on 
startup. 

Some are also very difficult to fix.  A low level kerberos library does 
a "access" check of all its config
files.  One of the checks is if (access(filename, W_OK))  this triggers 
an write denial, which we have
dontaudit for.  To change kerberos would envolve a serious redisign of 
lowlevel libraries.

Some are aguably running correctly just not the way SELinux wants them 
to.  IE Daemons having access to TTY's

Probably a lot of them are also legitimate bugs and should be 
bugzilla'd.  We can always use help if some one wants
to look for those situations.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
