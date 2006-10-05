From: Steve Grubb <sgrubb@redhat.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Thu, 5 Oct 2006 17:48:06 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil> <45256F49.1070105@us.ibm.com>
In-Reply-To: <45256F49.1070105@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610051748.06669.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 05 October 2006 16:47, Michael C Thompson wrote:
> AFAIK, we can't call audit without getting a failure, and I would really
> rather not suppress those errors.

There is a library function get_auditfail_action where admins can say what the 
expected behavior should be. There is a man page for it.

However, why would sending an audit message fail? newrole is setuid, that's 
why I did a code review last winter...and we can do another code review if 
people still aren't sure. pam is already used in several setuid programs, so 
I hope that is not the issue.

> It would be possible to add a check to make sure that either we have
> CAP_AUDIT_WRITE 

This is something simple to do and would solve your problem. 

> or euid=0 or something, but I'm not really fond of that.

By checking euid, you are really hoping that 0 has CAP_AUDIT_WRITE, so why not 
check the capability since that's what matters.

> RedHat: is there going to be a scenario where you are sending out this
> package on a system which doesn't have an audit-aware kernel?

No.

> If so, we can probably do the euid check and if euid is non-zero, we
> skip calling to audit. The fallout of that is you would see audit
> records when root, and only root, uses newrole. Again, I am not fond of
> this solution.

Me neither.

> Is there no sane way to check if an app is suid? Because this would
> relieve some of the headaches from this.

I don't think checking suid is the right thing. Checking the capability is.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
