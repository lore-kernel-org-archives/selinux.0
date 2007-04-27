Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RNdX6j014663
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 19:39:33 -0400
Received: from web51501.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3RNdW33002405
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 23:39:32 GMT
Date: Fri, 27 Apr 2007 16:38:57 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Patch to cleanup audit handling in policy.
To: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4632781D.2030406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <254813.17034.qm@web51501.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I have removed -send_audit_msgs_pattern and replaced it with 4 functions 

I'd like to clarify what they are in case anyone thinks the names need tweeking

logging_send_audit_msg - This is for any Trusted App that needs to send audit
events

logging_set_loginuid - This would be for entry point daemons or daemons that
perform actions on behalf of a user (cron/at). Includes the ability to send audit
events.

logging_set_audit - This should be for the audit daemon only

logging_set_auditctl - This is only for auditctl and autrace.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
