Subject: Re: crontab policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506301439.29861.russell@coker.com.au>
References: <200506301439.29861.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 08:36:01 -0400
Message-Id: <1120134961.11798.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 14:39 +1000, Russell Coker wrote:
> The attached patch is needed to allow the "crontab -u" checks to operate 
> correctly.  Without this the check always returns 0 and crontab will allow 
> root to create crontabs for anyone regardless of SE Linux context.
> 
> Note that it may be necessary to go further.  I am operating under the 
> assumption that if you want to grant a particular crontab domain the access 
> to create crontab files for other users then you will grant extra access to 
> the crontab domain as well as the "passwd crontab" access to the parent 
> domain in the policy.  Maybe we should allow all $1_crontab_t domains to 
> perform the security checks?

This should be done via macros, e.g. can_getsecurity() provides the
necessary permissions to get security decisions via selinuxfs.  Not sure
that the ability to read /etc/selinux/config is truly necessary, as you
only need that to find out the paths to the policy files, which aren't
required for using selinuxfs.  userspace_objmgr defines a broader set of
permissions including the ability to get security decisions,
read /etc/selinux/config and /etc/selinux/$SELINUXTYPE/contexts, and get
notifications of policy reloads and changes to the enforcing flag via
netlink.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
