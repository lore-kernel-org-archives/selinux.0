Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UH4XEm007943
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 13:04:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UH4Wj8026908
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 17:04:33 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46360CEB.3020106@redhat.com>
References: <254813.17034.qm@web51501.mail.re2.yahoo.com>
	 <1177942650.3570.78.camel@sgc>  <4635FC63.3000003@redhat.com>
	 <1177943981.3570.90.camel@sgc>  <4636036C.8060208@redhat.com>
	 <1177946990.3570.103.camel@sgc>  <46360CEB.3020106@redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 17:04:12 +0000
Message-Id: <1177952652.3570.124.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-30 at 11:36 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2007-04-30 at 10:55 -0400, Daniel J Walsh wrote:
> >> Christopher J. PeBenito wrote:
> >>> On Mon, 2007-04-30 at 10:25 -0400, Daniel J Walsh wrote:
> >>>> Christopher J. PeBenito wrote:
> >>>>> On Fri, 2007-04-27 at 16:38 -0700, Steve G wrote:
> >>>>>>> I have removed -send_audit_msgs_pattern and replaced it with 4 functions 
> >>>>>>> 
> >>>>>> I'd like to clarify what they are in case anyone thinks the names need tweeking
> >>>>>>
> >>>>>> logging_send_audit_msg - This is for any Trusted App that needs to send audit
> >>>>>> events
> >>>>>>
> >>>>>> logging_set_loginuid - This would be for entry point daemons or daemons that
> >>>>>> perform actions on behalf of a user (cron/at). Includes the ability to send audit
> >>>>>> events.
> >>>>>>
> >>>>>> logging_set_audit - This should be for the audit daemon only
> >>>>>>
> >>>>>> logging_set_auditctl - This is only for auditctl and autrace.
> >>>>>>             
> >>>>> I'm not convinced that these are necessary.  The assertions in the
> >>>>> policy are mainly to stop people from accidentally shooting themselves
> >>>>> in the foot by allowing potentially dangerous access, for example,
> >>>>> access to /etc/shadow or raw disk access.
> >>>>>           
> >>>> When I reviewed the policy, almost ever call to allow audit was wrong.  
> >>>>         
> >>> Wrong in what sense?
> >>>       
> >> Wrong in the sense of granting more privs then they intended.  Login 
> >> programs being able to change the audit rules.  audit_control versus 
> >> audit_write and netlinkmsg_write versus netlinkmsg_relay.  Better to put 
> >> them into interfaces and force policy writers to use them.
> >
> > This is an argument for more patterns, which would be fine.   
> 
> Why would we want patterns over interfaces?  We can not use constraints 
> in interfaces.  I want constraints to stop people from making dumb 
> mistakes.

Having assertions would make the interfaces needed, but I still argue
that they aren't required in this instance; see my response to Steve.

>   The interface most often uses is logging_send_audit_msg which 
> matches up very closely to logging_send_syslog_msg.

This is the most compelling argument so far, but I don't think I'm
convinced yet.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
