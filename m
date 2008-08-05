Subject: Re: Question about newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: Xavier Toth <txtoth@gmail.com>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <200808052232.03624.linuxweb@gmx.net>
References: <200808052155.18105.linuxweb@gmx.net>
	 <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>
	 <200808052232.03624.linuxweb@gmx.net>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 10:48:55 -0400
Message-Id: <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
> Thanks.
> That seems to help quite a bit.
> I now get some messages. For example it seems that newrole wants to 
> read /etc/shadow directly.
> Will check those messages and play around with the policy.

The way it works is that pam_unix attempts to open /etc/shadow directly
for reading, and if it fails, it falls back to running unix_chkpwd to
perform the password check.  SELinux policy prohibits most programs from
directly reading /etc/shadow, including even ones that run as root, and
forces them to go through unix_chkpwd instead, in order to limit the set
of processes that have full read access to the shadow password file.

The logic to try to open /etc/shadow and fall back to unix_chkpwd
already existed before SELinux in order to support non-root processes
re-authenticating the current user.  What changed with SELinux was that
it could also happen for root processes.

The current policy dontaudit's the attempt to directly read /etc/shadow
to avoid noise.  When you did semodule -DB, you turned on that auditing.
But those denials are what is expected, and allowing them will mean
giving newrole direct read access to /etc/shadow (although that will
only work if running as root, of course, as otherwise it has to use a
suid helper like unix_chkpwd anyway).

Does newrole work for you as a non-root user?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
