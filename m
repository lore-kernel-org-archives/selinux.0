Subject: Re: Logrotate, ssh_agent - read selinux_config_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1112298109.12948.80.camel@cobra.ivg2.net>
References: <1112295975.12948.72.camel@cobra.ivg2.net>
	 <1112295549.11216.162.camel@moss-spartans.epoch.ncsc.mil>
	 <1112298109.12948.80.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 14:37:24 -0500
Message-Id: <1112297844.11216.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 14:41 -0500, Ivan Gyurdiev wrote:
> [phantom@cobra ~]$ SYMBOLS=`cat /usr/include/selinux/*|grep extern|sed
> -e s/\(.*//|sed -e s/.*" "//|grep ^[a-zA-Z]`
> [phantom@cobra ~]$ for SYMBOL in $SYMBOLS; do if [ ! -z "`grep
> $SYMBOL /usr/sbin/logrotate`" ]; then echo $SYMBOL; fi; done;
> is_selinux_enabled
> freecon
> getfscreatecon
> setfscreatecon
> getfilecon
> fgetfilecon
> selinux_getenforcemode
> [phantom@cobra ~]$ for SYMBOL in $SYMBOLS; do if [ ! -z "`grep
> $SYMBOL /usr/bin/ssh-agent`" ]; then echo $SYMBOL; fi; done; 
> 
> What does that mean - should they both be blocked, or only ssh-agent?

Of those functions, only selinux_getenforcemode() would need to
read /etc/selinux/config, and I'm not sure why logrotate is using it
instead of security_getenforce(), i.e. checking the current
enforcing/permissive status rather than the one specified for boot-time
in /etc/selinux/config.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
