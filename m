Subject: Re: Proposed patch for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41790F02.8070207@redhat.com>
References: <41782BBA.9090101@redhat.com>
	 <1098451420.7614.43.camel@moss-spartans.epoch.ncsc.mil>
	 <41790F02.8070207@redhat.com>
Content-Type: text/plain
Message-Id: <1098454526.7614.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 10:15:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 09:45, Daniel J Walsh wrote:
> Why is this not covered by the current checks of setting file context.  
> I don't think this is a special case.
> If a domain can setfilecon, they should be able to set it permanently

Debatable.  Today, a domain may be able to relabel files, but an
explicit relabel of the filesystem will always override those settings,
which may be exactly what you want if you are doing a major policy
upgrade.  In general, one shouldn't be running setfiles on a system
after installation except for major policy upgrades anyway.  Allowing a
domain to opt-out of subsequent relabels by default is new
functionality; I think it requires a separate permission from
relabelfrom.

> setfileconfixed?
> setfileconpermanent?
> lockfilecon?
> customizefilecon?
> 
> I don't  care what we call it.

Do we think it possible that we may support other flags related to file
contexts in the future?  If so, then perhaps this should be a general
flags field associated with the file context with a
setfileconflags(path, flags), getfileconflags(path, flags) API and a
single flag defined initially for marking the context as explicitly
customized.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
