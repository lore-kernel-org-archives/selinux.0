Subject: Re: Logrotate, ssh_agent - read selinux_config_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112295975.12948.72.camel@cobra.ivg2.net>
References: <1112295975.12948.72.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 13:59:09 -0500
Message-Id: <1112295549.11216.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 14:06 -0500, Ivan Gyurdiev wrote:
> logrotate and ssh_agent try to read /etc/selinux/config and fail.
> I thought it would be reasonable to allow that, but I see this:
> 
> apache_macros.te:dontaudit httpd_$1_script_t selinux_config_t:dir
> search;
> crontab_macros.te:dontaudit $1_crontab_t selinux_config_t:dir search;
> inetd_macros.te:dontaudit $1_t selinux_config_t:dir search;
> ssh_agent_macros.te:dontaudit $1_ssh_agent_t selinux_config_t:dir
> search;
> ssh_macros.te:dontaudit $1_ssh_keysign_t selinux_config_t:dir search;
> xserver_macros.te:dontaudit $1_xserver_t selinux_config_t:dir search;
> 
> Why?

libselinux reads /etc/selinux/config from a constructor to set up the
paths to the policy files for later use internally or by the
application.  This ends up triggering a lot of unnecessary attempts to
read it by programs that happen to link with libselinux but don't ever
need to access a policy path.  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
