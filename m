Subject: Re: general security lib (was: 2.6.0-test3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200308230009.19552.russell@coker.com.au>
References: <1061468940.1665.16.camel@kusturica>
	 <1061487623.22355.27.camel@columbia> <1061555921.1648.142.camel@kusturica>
	 <200308230009.19552.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 10:32:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 10:09, Russell Coker wrote:
> A modification to PAM could allow the sshd, login, and cron patches to go 
> away.
> 
> Theodore Ts'o suggested to me that a new PAM call be added to run the shell 
> which takes appropriate parameters about user-name etc.  Then a SE Linux 
> version of this module could change the security context appropriately, thus 
> requiring only one copy of the code to determine the context to use, and not 
> requiring any on-going modification to applications.
> 
> This design concept sounds really good, and as it's Ted's suggestion I don't 
> expect any great resistance to accepting the patch upstream once it's been 
> tested and proven to work.
> 
> I've been meaning to work on this for almost a year, I might start work next 
> week.

If you investigate this idea, be sure to work from the new SELinux
patches that use the new SELinux API, not the old one.  Note that the
new SELinux API is better suited to encapsulation within PAM, since the
exec context is now an attribute of the process that can be set prior to
the execve call.  PAM could call setexeccon() when it ordinarily sets
the user's credentials.  This avoids the need to create a new PAM call,
or to alter the execve call itself.

While you may be able to move the setup of the user execution context
into PAM, there are other elements of the SELinux patches as well, such
as the labeling of the tty/pty and the entrypoint check for cron jobs. 
Hence, I suspect that we will still need some kind of patch for
login/sshd/crond, albeit a smaller one. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
