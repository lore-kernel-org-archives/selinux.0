Subject: Re: Re:[Patch 0/2] libsemanage: remember and retrieve dontaudit
 settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4C168C.2040900@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com>  <4A4C168C.2040900@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:33:46 -0400
Message-Id: <1246538026.13464.262.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 22:08 -0400, Christopher Pardy wrote:
> This is a heavily modified version of the patch I recently submitted. It 
> provides 3 new functions: in libsepol sepol_get_disable_dontaudit; in 
> libsemanage semanage_get_disable_dontaudit; in libselinux 
> is_dontaudit_disabled. It also fixes issues with the previous patch.
> 
> The justification for this patch is the same as the one I posted 
> earlier. Simply, there is currently no way to know if dontaudit rules 
> are  enabled. Additionally once don't audit rules are turned they turn 
> themselves off after policy rebuild (is that the desired functionality?) 

semodule -DB should still strip dontaudit rules from the policy, and
semodule -B should still restore them.  The only thing that should
change IIUC is that semodule -DB should persist across any other
semodule or semanage operations other than semodule -B.

> This patch provides  a way to check on both the current and pending 
> state of the dontaudit rules and it maintains this state between policy 
> rebuilds.
> 
> Signed-off-by Christopher Pardy <cpardy@redhat.com>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
