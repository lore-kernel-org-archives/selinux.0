Subject: Re: Issue on getting security context of socket and message
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050310103322.86495.qmail@web51503.mail.yahoo.com>
References: <20050310103322.86495.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 08:02:51 -0500
Message-Id: <1110459771.8434.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-10 at 02:33 -0800, Park Lee wrote:
> Does this mean that LSM doesn't provide any system 
> call for security-aware applications now? (While, in
> the past, it provided a security system call for such
> applications)
> 
> and,
> 
> Except for not supporting the extended socket API,
> Does SELinux now support other extended API (e.g.
> extended file API and extended process API)? 
> Does security server still provide system calls for
> security_aware applications?

This is discussed in several places, e.g.:
selinux-doc/PORTING
selinux-doc/module/syscall.sgml (in the latest selinux-doc, version
1.18)
http://www.nsa.gov/selinux/papers/module/x360.html
http://www.nsa.gov/selinux/papers/ols2003-selinux/text8.html

Please look at the existing documentation and mailing list archives
(more easily searchable via marc.theaimsgroup.com/?l=selinux) before
asking questions here.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
