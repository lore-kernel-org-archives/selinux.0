Subject: Re: security files - why not sysadmfile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109619491.17982.7.camel@cobra.ivg2.net>
References: <1109440349.11452.7.camel@cobra.ivg2.net>
	 <1109617986.28470.41.camel@moss-spartans.epoch.ncsc.mil>
	 <1109619491.17982.7.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:31:57 -0500
Message-Id: <1109619117.28470.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-28 at 14:38 -0500, Ivan Gyurdiev wrote:
> So, what's the proper way for a user to edit policy source files
> (which is the purpose of the selinux-sources package) without 
> running into denials.

The ultimate goal is that they won't have to do that.
In the absence of the necessary policy infrastructure (for which Tresys
Technology is developing components), possibly it makes sense to assign
sysadmfile to the policy file types for now.  security_t is only for
selinuxfs and shouldn't be assigned to any file edited by a user anyway,
so there is no reason to make it sysadmfile.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
