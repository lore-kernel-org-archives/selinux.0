Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux-dev@tresys.com, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20060513200016.GE7481@thorium.jmh.mhn.de>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605071136100.8588@d.namei>
	 <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0605081947400.19850@d.namei>
	 <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0605091146350.25693@d.namei>
	 <20060510221146.GG8937@thorium.jmh.mhn.de>
	 <1147351945.8341.114.camel@moss-spartans.epoch.ncsc.mil>
	 <20060513200016.GE7481@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Mon, 15 May 2006 08:32:28 -0400
Message-Id: <1147696348.14426.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-05-13 at 22:00 +0200, Thomas Bleher wrote:
> How about the following idea:
> On policy load time, the kernel compares the list of classes (file,
> packet, ...) and permissions (read, write, ...) with the ones defined in
> the policy. If something is missing, the kernel alerts the user on the
> console and through the audit system that the system may be unusable
> because of missing permissions and that he should update his SELinux
> userspace.
> 
> I think this should solve the problem of how to inform the user without
> compromising security and continually having to add cruft to the kernel
> to support old policy.
> 
> What do you think about this?

That could be done (by checking the contents of the string tables used
by the AVC for displaying avc messages against the loaded policy),
although it would only detect the case where you have a new kernel
implementing new classes and/or permissions with an old policy that does
not define them, not vice versa.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
