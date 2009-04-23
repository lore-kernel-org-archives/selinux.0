Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3NCtbrW005445
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 08:55:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n3NCta5A022783
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 12:55:36 GMT
Subject: Re: [refpolicy] runcon cant really run(constraint issue?)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Justin Mattock <justinmattock@gmail.com>,
        tresys <refpolicy@oss.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <49F0618C.4080101@redhat.com>
References: <dd18b0c30904220938y781d0009y7c2229aa28952c2e@mail.gmail.com>
	 <49F0618C.4080101@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 08:54:43 -0400
Message-Id: <1240491283.19211.805.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-23 at 08:39 -0400, Daniel J Walsh wrote:
> On 04/22/2009 12:38 PM, Justin Mattock wrote:
> > looking into using runcon
> > it seems I'm confronted with an
> > avc, that just keeps showing up:
> > allow staff_t user_t:process { siginh rlimitinh transition noatsecure };
> > (even after adding this to the policy).
> >
> > What I'm doing is this:
> > runcon name:user_r:user_t:s0-s0:c0.c255 firefox
> > the initial role I'm in is staff_r(transitioning to user_r for
> > firefox to run in)
> >
> > Does this seem like the right thing to do,
> > or do I need to use newrole -r *
> > for something like firefox?
> >
> I guess the correct question is what is your security goal.
> 
> You are not currently allowed to transition from a staff_u user to a 
> user_r role.  In order to make this happen you would need to use semange 
> to make sure your SELinux user "name" had both staff_r and user_r, and 
> then you would need to add a rule to policy that says staff_r can become 
> user_r.

There is also a transition constraint when the role is changing.  You
have to be coming from a domain that is allowed to do role changing,
such as newrole_t.  User domains (except unconfined_t) are not allowed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
