Subject: Re: Newrole in targeted mode
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Nick Gray <nick-lists@austin.rr.com>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
	 <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 30 Dec 2004 12:07:08 +0530
Message-Id: <1104388628.3140.4.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I tried to search and couldn't find any threads on this question ..

What are the basic differences between targeted and strict policies ..

All I know is .. there are lesser targeted domains/roles in target
policy compared to strict and as a result most domains run in an
unconfined_t domain.

Am I missing something ...

On Tue, 2004-12-28 at 13:50 -0500, Stephen Smalley wrote:
> newrole serves no purpose under targeted policy; users are unconfined.
> setenforce 0 should work for you as root (from unconfined_t, of course,
> which is what you should already be in for a user session).

You can add new users and roles in target policy also ... 
In that case newrole should work as per the modified policies .. I am wrong ??

Regards,
Jaspreet

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
