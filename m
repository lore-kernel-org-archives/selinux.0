Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA22690
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 07:19:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA16349
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:19:16 GMT
Received: from web40009.mail.yahoo.com (web40009.mail.yahoo.com [66.218.78.27])
	by jazzswing.ncsc.mil  with SMTP id LAA16345
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:19:15 GMT
Message-ID: <20020712111941.30466.qmail@web40009.mail.yahoo.com>
Date: Fri, 12 Jul 2002 04:19:41 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: revising the su decision
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020712020642.D58E442F2@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> Up until now the su program was not modified, so changing to a different UID 
> was a separate and independant operation from changing domain via newrole.
> 
> However now that the sshd policy has been set to default to not allow logins 
> as sysadm_r:sysadm_t this causes some inconveniance.  I have to ssh in to my 
> server as a non-root account with a non-sysadm_r context.  Then I have to use

> newrole to change to sysadm_r (entering the password), and then I have to su 
> to the root account (entering the root password).
> 
> This requires entering the password two times (or three if not using ssh 
> authorized_keys).
> 
> This is excessively painful, and I think that to make SE Linux more usable we

> need to address this issue, possibly by changing su to allow it to change 
> roles too.
> 
> What do you think?

          Why do you have to change your role to sysadm_r before su'ing to
root? I was under the impression that becoming uid 0 by either logging in or
su'ing was sufficient.....

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Sign up for SBC Yahoo! Dial - First Month Free
http://sbc.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
