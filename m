Subject: Re: Logrotate, ssh_agent - read selinux_config_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <424C56C9.60603@redhat.com>
References: <1112295975.12948.72.camel@cobra.ivg2.net>
	 <1112295549.11216.162.camel@moss-spartans.epoch.ncsc.mil>
	 <1112298109.12948.80.camel@cobra.ivg2.net>
	 <1112297844.11216.178.camel@moss-spartans.epoch.ncsc.mil>
	 <424C56C9.60603@redhat.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 14:58:34 -0500
Message-Id: <1112299114.11216.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 15:00 -0500, Daniel J Walsh wrote:
> logrotate patch is fixed, will be in tomorrow's build.  I believe 
> logrotate will need to read these files,
> not sshd. 

If the patch is fixed, then logrotate shouldn't need access
to /etc/selinux/config or the policy paths either.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
