Subject: Re: Problem Setting Policy To Enforcing Mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: erahul29@yahoo.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <459507.37401.qm@web50206.mail.re2.yahoo.com>
References: <459507.37401.qm@web50206.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 13:37:16 -0500
Message-Id: <1227292636.7319.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-11-21 at 06:59 -0800, Rahul Jain wrote:
> Hi All,
>  
> This is the first time I am writing to this mailing list in hope of
> receiving help. I am trying to port reference policy by tresys on
> Montavista. I am able to run the policy well in permmisive mode with
> no avc messages in audit log, kern.log or messages. But when I put the
> policy into enforcing mode my system fails to boot, reason seems to
> be problem with init process. I am not able to debug the problem
> because no avc messages are generated for the same, probably because
> the issue comes up even before logging deamons start. Is there anyway
> I can debug my policy and log the avc messages from the very beginning
> of the system startup.
>  
> Rahul Jain
> Rahul Jain  

If you boot the system in permissive mode, check to see if you have a
policy loaded and whether your filesystem is labeled correctly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
