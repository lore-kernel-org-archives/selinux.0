Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n483pmuY008716
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 23:51:48 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n483tQ7N028807
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 03:55:27 GMT
Message-ID: <4A03AC41.1040505@schaufler-ca.com>
Date: Thu, 07 May 2009 20:51:29 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        viro@ZenIV.linux.org.uk, sds@tycho.nsa.gov
Subject: Re: SELinux and access(2), we want to know.
References: <1241723924.2791.107.camel@localhost.localdomain> <20090507195729.GA21104@us.ibm.com>
In-Reply-To: <20090507195729.GA21104@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):
>   
>> 3) I've also heard it hinted that we could do this with audit by just
>> having audit drop the denials that include the access(2) syscall and the
>> scontext and tcontext for the slew of things the SELinux policy writers
>> know we are not interested in.  And while it seems good, now we have
>>     
>
> What is the difference whether an attacker does access(2) to check for
> /etc/shadow rights, or does a failed open()?
>   

I have been studiously ignoring the discussions on the SELinux list because
in the end it really doesn't matter, as Serge (appears to) point out here.
The access() system call was a major thorn in the side of the POSIX security
working group because its behavior is not really very rational. By design
it does not take into account read-only file systems, ACLs, MAC labels,
TOMOYO policy, or anything other than the mode bits. A successful return
from access() gives you no assurance whatever that if you actually try the
operation it will succeed. My recollection is that every version of
"trusted unix" written treats the system call the same way it would a
call to lstat(), because that's really all it is doing.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
