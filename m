Message-ID: <1344614902.10631.70.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Fri, 10 Aug 2012 12:08:22 -0400
In-Reply-To: <20120810154454.GH2296@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810121113.GE2296@telvanni>
	 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810143656.GF2296@telvanni>
	 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810154454.GH2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 17:44 +0200, Ole Kliemann wrote:
> PS: Have you actually reproduced this problem? Could still be 
> something else broken on my system...

No, I haven't tried, as you didn't supply a complete policy.

Two other items to double check:
- Are you running auditd, and if so, did you check that you aren't
flooding it?  That won't show up in dmesg, only
in /var/log/audit/audit.log.

- Are you running mcstrans?  If so, disable it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
