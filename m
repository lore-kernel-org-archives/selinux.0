Subject: Re: security files - why not sysadmfile
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109617986.28470.41.camel@moss-spartans.epoch.ncsc.mil>
References: <1109440349.11452.7.camel@cobra.ivg2.net>
	 <1109617986.28470.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:38:11 -0500
Message-Id: <1109619491.17982.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-28 at 14:13 -0500, Stephen Smalley wrote:
>On Sat, 2005-02-26 at 12:52 -0500, Ivan Gyurdiev wrote:
>> Why are those types not marked sysadmfile?
>> This is particularly annoying when vi spits out
>> error messages every time I edit a selinux source file.
>
>The goal is to ultimately remove direct access to many file types by
>sysadm_t, and only allow permissions to specific programs when run by
>sysadm_t.  That reduces your risk of accidental corruption by the admin
>and of intentional corruption or leakage by malicious code unwittingly
>run by the admin.  In particular, protecting the policy in this manner
>is important.

So, what's the proper way for a user to edit policy source files
(which is the purpose of the selinux-sources package) without 
running into denials.
>
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
