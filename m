Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <200506102105.j5AL5A5F003141@gotham.columbia.tresys.com>
References: <200506102105.j5AL5A5F003141@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:47:32 -0400
Message-Id: <1118440053.4812.60.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Creating more least-privilege code limits the damage from malicious code,
> certainly, but in this case it doesn't fix all problems. Some code will be run
> in the user domain that will be exploitable or the user will simply run a
> Trojan. At that point the malicious code running in user_t can, for example,
> disclose sensitive user data by either moving it or relabeling it so that an
> application like apache can read it. This can potentially be addressed but it
> will be enormously difficult and time consuming.

ROLE_t has access to cp, which equates a relabel, does it not?
If the user can read the file... 

> A post install script that creates directories and/or relabels existing
> directories.

... ok



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
