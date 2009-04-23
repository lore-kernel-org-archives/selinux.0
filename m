Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3NCdkb2003318
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 08:39:46 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3NCdjrY020592
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 12:39:45 GMT
Message-ID: <49F0618C.4080101@redhat.com>
Date: Thu, 23 Apr 2009 08:39:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: tresys <refpolicy@oss.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: runcon cant really run(constraint issue?)
References: <dd18b0c30904220938y781d0009y7c2229aa28952c2e@mail.gmail.com>
In-Reply-To: <dd18b0c30904220938y781d0009y7c2229aa28952c2e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/22/2009 12:38 PM, Justin Mattock wrote:
> looking into using runcon
> it seems I'm confronted with an
> avc, that just keeps showing up:
> allow staff_t user_t:process { siginh rlimitinh transition noatsecure };
> (even after adding this to the policy).
>
> What I'm doing is this:
> runcon name:user_r:user_t:s0-s0:c0.c255 firefox
> the initial role I'm in is staff_r(transitioning to user_r for
> firefox to run in)
>
> Does this seem like the right thing to do,
> or do I need to use newrole -r *
> for something like firefox?
>
I guess the correct question is what is your security goal.

You are not currently allowed to transition from a staff_u user to a 
user_r role.  In order to make this happen you would need to use semange 
to make sure your SELinux user "name" had both staff_r and user_r, and 
then you would need to add a rule to policy that says staff_r can become 
user_r.  But transitioning to the new role is probably not what you want.

If your goal is to confine firefox. you would be better off using the 
mozilla policy to say when a staff_t type executes mozilla_exec_t it 
runs as staff_mozilla_t.

name:staff_r:staff_t -> system_u:object_r:mozilla_exec_t -> 
name:staff_r:staff_mozilla_t

Confining mozilla/firefox has  a whole bunch of other problems...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
