Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA12032
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 19:10:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA29342
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 23:09:17 GMT
Received: from web40012.mail.yahoo.com (web40012.mail.yahoo.com [66.218.78.30])
        by jazzband.ncsc.mil  with SMTP id XAA29338 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 23:09:17 GMT
Message-ID: <20020819231053.24335.qmail@web40012.mail.yahoo.com>
Date: Mon, 19 Aug 2002 16:10:53 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Changing the default role/type of a user
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020819224448.7446C129F@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:
> On Tue, 20 Aug 2002 00:01, Brad Chapman wrote:
> > In my policy, my username of Brad is placed in the role user_r and the
> > domain user_t. However, the login program has my username in the role
> > sysadm_r and the domain sysadm_t, despite there being no such role
> > configured in the users file. Why does the login program do this?
> 
> It sounds like it's set to that in /etc/security/default_context .
> 
> Although if the policy doesn't permit this then login should not be allowed 
> to do it.  Are you running in permissive mode?

Yes, but when I try to login with Brad:sysadm_r:sysadm_t, it fails, since I
don't have that role in the list in the users file; AAR, it complains that
there's no SID for it. So I enter user_r and user_t for my role/type, which 
IS in the users file, and it logs in happily.

I am using permissive mode right now, because I want to be absolutely sure that
the parts of the policy which apply to what I do are foolproof. My su_macros
and user_macros files are growing again, but otherwise my (or your) policy is
quite well set up, IMO.

Brad


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
