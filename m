Subject: Re: No such file or directory:
 '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Denis BUCHER <dbucherml@hsolutions.ch>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4B83FED0.208@hsolutions.ch>
References: <4B83FED0.208@hsolutions.ch>
Content-Type: text/plain
Date: Tue, 23 Feb 2010 11:29:06 -0500
Message-Id: <1266942546.871.26.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-23 at 17:14 +0100, Denis BUCHER wrote:
> Dear all,
> 
> I got the following error while I just wanted to change the homedir of a 
> user. I hope it's the right place to ask ? (Nothing found on the web)
> 
> # usermod -d <path> <user>
> 
> /usr/sbin/genhomedircon: [Errno 2] No such file or directory: 
> '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
> usermod: warning: unable to relabel the homedir (...)
> 
> But homedir was changed anyway...
> 
> Just to let you know... (?)

If you are using Fedora, then this would be best directed to
selinux@lists.fedoraproject.org (formerly
fedora-selinux-list@redhat.com).

It would help to identify your distribution, shadow-utils version,
SELinux status (sestatus), etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
