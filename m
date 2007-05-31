Subject: Re: [PATCH] SELinux protection for exploiting null
	dereference	using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ulrich Drepper <drepper@redhat.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, alan@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        chrisw@redhat.com
In-Reply-To: <465EE1C9.3020809@redhat.com>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <Line.LNX.4.64.0705301954080.19731@d.namei>
	 <1180590362.3969.11.camel@localhost.localdomain>
	 <Line.LNX.4.64.0705310943170.23949@d.namei>
	 <1180622751.3340.269.camel@moss-spartans.epoch.ncsc.mil>
	 <465EE1C9.3020809@redhat.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 11:07:04 -0400
Message-Id: <1180624024.3340.283.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 07:55 -0700, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > Or it could be a sysctl value if you wanted it to generalize beyond
> > selinux.
> 
> That's likely the right answer.  But then you need to protect changing
> the value.  How does SELinux deal with that?

The policy can label sysctls based on their name (since there we can
generate a reliable stable name from kernel data that isn't subject to
userspace manipulation or aliasing, unlike typical pathnames), and then
control access based on the TE type.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
