Subject: Re: security files - why not sysadmfile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109440349.11452.7.camel@cobra.ivg2.net>
References: <1109440349.11452.7.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:13:06 -0500
Message-Id: <1109617986.28470.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-02-26 at 12:52 -0500, Ivan Gyurdiev wrote:
> Why are those types not marked sysadmfile?
> This is particularly annoying when vi spits out
> error messages every time I edit a selinux source file.

The goal is to ultimately remove direct access to many file types by
sysadm_t, and only allow permissions to specific programs when run by
sysadm_t.  That reduces your risk of accidental corruption by the admin
and of intentional corruption or leakage by malicious code unwittingly
run by the admin.  In particular, protecting the policy in this manner
is important.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
