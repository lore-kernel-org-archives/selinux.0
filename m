Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: casey@schaufler-ca.com, russell@coker.com.au, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
In-Reply-To: <45377BF0.6010403@redhat.com>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 09:30:13 -0400
Message-Id: <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 09:21 -0400, Daniel J Walsh wrote:
> So one proposed solution to this is to take away the newrole -l 
> functionality all together and to add Sensitivity selection to the local 
> login. 
> 
> We can implement pam_selinux to ask for the sensitivity level
> 
> 
> username: dwalsh
> passwd: ********
> Sensitivity: SystemLow
> 
> If we then remove -l from newrole we are done?

pam_selinux used to have support to let the user pick from the list of
reachable contexts for the user.  So you could just restore that
support.

That doesn't address sshd though.  Or gdm.  sshd shouldn't be too
difficult.  There were some externally developed gdm patches for selinux
that enabled context selection long ago, but nothing recent
(pre-Fedora).

You don't need to remove -l from newrole; you can just constrain its use
via DAC and via SELinux policy, as Klaus has previously suggested.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
