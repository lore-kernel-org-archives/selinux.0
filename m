Message-ID: <20050310103322.86495.qmail@web51503.mail.yahoo.com>
Date: Thu, 10 Mar 2005 02:33:22 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on getting security context of socket and message
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 09 Nov 2004 at 10:39, Stephen Smalley wrote:
> Since sys_security was rejected by the mainline 
> kernel, the extended socket API of SELinux is not 
> presently supported; 

Does this mean that LSM doesn't provide any system 
call for security-aware applications now? (While, in
the past, it provided a security system call for such
applications)

and,

Except for not supporting the extended socket API,
Does SELinux now support other extended API (e.g.
extended file API and extended process API)? 
Does security server still provide system calls for
security_aware applications?


Thank you.

Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
