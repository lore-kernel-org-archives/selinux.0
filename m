Subject: Re: memory access restrictions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Davies <m.p.davies@newi.ac.uk>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6.2.1.2.0.20050309144019.03a894d0@cronus.newi.ac.uk>
References: <6.2.1.2.0.20050309144019.03a894d0@cronus.newi.ac.uk>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 11:08:06 -0500
Message-Id: <1110384486.3791.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-09 at 14:49 +0000, Mark Davies wrote:
> From what I have seen of SELinux and (most) other operating systems
> there is no control over what memory locations a program running can
> access. Malicious code in user areas could therefore access privileged
> information that has been put into memory by other programs,
> specifically worrying is the ability to access system level programs.
> With access is the potential for such data to be altered to help a
> user raise their privileges and so this is potentially a security
> concern. My question is, therefore, is anything being done to
> counteract this? My first idea was to have the kernel create an
> "exception" (not really the right term I know) in a program that tries
> to access any memory that has not been allocated to it. Your comments
> would be greatly appreciated, especially since I should like to
> implement such controls in the short term.

Process isolation is already provided by most operating systems,
including Linux.  What SELinux provides is the ability to enforce
separation based on security properties, e.g. to separate different
classes of processes to ensure confidentiality or integrity guarantees.
Basic memory protection of the process is already provided by Linux, but
SELinux mediates the ability of processes to interact via shared
resources such as files, IPC objects, shared memory, etc.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
