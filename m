Subject: Re: sshd error: Failed to get default security context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
	 <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
	 <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 07:18:28 -0400
Message-Id: <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-10-19 at 18:43 -0700, Larry Ross wrote:

> 
>   One question, what do you mean when you say "seusers configuration"?
> Is that the files in <policy type>/contexts/users or the information
> maintained by semanage or something else?

It is the information managed by semanage login, or by the User Mapping
tab of the system-config-selinux tool.  The configuration file
is /etc/selinux/$SELINUXTYPE/seusers.  It maps Linux usernames (logins)
to a (SELinux user identity, MLS/MCS range) pair.  Present in RHEL5, not
in RHEL4.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
