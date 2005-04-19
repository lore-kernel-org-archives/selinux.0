Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3K0ct7C026961
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 20:38:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3K0VPm9004747
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 00:31:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: Proposed policy feature: $1_domain attribute
Date: Tue, 19 Apr 2005 23:32:26 +1000
Cc: selinux@tycho.nsa.gov
References: <1109685518.764.9.camel@cobra.ivg2.net>
In-Reply-To: <1109685518.764.9.camel@cobra.ivg2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504192332.29946.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 02 March 2005 00:58, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> I'd like to mark all role-dependent domains with a new attribute
> $1_domain (analogous to $1_file_type), and then do the following in
> base_user_macros.te:
>
> can_ps($1, $1_domain)
> can_ptrace($1, $1_domain)
>
> Objections?

I'm catching up on email.

I object to the policy you suggest above for the same reasons as everyone 
else.

However I believe that there is one significant point which has been 
overlooked.

If I want to allow a domain (such as staff_t) to be able to manage the role 
user_r then there is currently no complete way of doing it.  Policy such as 
the following is commonly used to allow staff_t to kill user processes that 
are doing undesired things:
can_ps(staff_t, user_t)
allow staff_t user_t:process signal;

This of course doesn't permit staff_t to see or kill user_gpg_t etc.

Something like the following might be useful:
can_ps(staff_t, user_domain)
allow staff_t user_domain:process signal;

If I was running a university shell server I would probably give some trusted 
postgrad students access to UID 0 and have policy such as the following:
can_ps(postgrad_t, user_domain)
allow postgrad_t user_domain:process signal;

That would keep the under-graduate students in line...


So I think that having an attribute for user domains makes sense.  Having an 
attribute named user_domain as well as an attribute userdomain is a bad idea.  
The name $1_domain seems appropriate, so maybe we should rename the current 
userdomain attribute to user_login_domain (which is a better name anyway) 
before implementing this.

We could then have assertions to prevent the obvious mistakes such as allowing 
ptrace of a more privileged process in the policy macros for gpg etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
