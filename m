Subject: Re: Default Policy question?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <3EDB7585.8050308@redhat.com>
References: <3EDB7585.8050308@redhat.com>
Content-Type: text/plain
Message-Id: <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Jun 2003 13:21:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-06-02 at 12:04, Daniel J Walsh wrote:
> Has anyone discussed the problem of having root be a member of the 
> sysadm_r role.  Is there a way to define policy such that you could
> allow a sysadmin to manipulate configuration without allowing them to
> effect policy?  Ie, does the default policy allow someone the ability to
> change the /etc/printcap file but not run load_policy?  Should we have 
> three levels of user by default.  My problem with this is that 
> sysadmin's are going to become root and run newrole to sysadm_r to 
> manipulate configuration.  If they stay newrole and run a trojaned app,
> security is compromized.
> 
> user_r    - Very little privs for general users
> sysadm_r  - Ability to manipulate all standard Linux config files.
> policy_r  - Ability to change the way the kernel handles policy. 
> (/etc/security/selinux/*, /etc/grup.conf, chsid, avc_toggle ...)
> 
> policy_r should not be defaulted to the root user but garnered in some 
> other way.

The idea of having a separate security administrator has come up before
on the list (see the archives), and was initially explored during the
early stages of the example policy development.  However, separating a
security administrator from the system administrator is difficult unless
you significantly prune what a typical system administrator can do;
otherwise, the system administrator can subvert the software,
configuration or environment of the security administrator and
effectively take control of it.  I'm not saying that it isn't a good
idea, if for no other reason than to guard against carelessness;
splitting up sysadm_r in general would be useful, and limiting sysadm_t
(or its replacements) to executing a small set of trusted code would
likewise be useful.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
