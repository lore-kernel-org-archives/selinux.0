Subject: RE: questions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: awilson@tresys.com
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <AFECILBIKCHPGNOEDGNCGEOHDOAA.awilson@tresys.com>
References: <AFECILBIKCHPGNOEDGNCGEOHDOAA.awilson@tresys.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061836213.28086.550.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Aug 2003 14:30:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-25 at 10:54, Art Wilson wrote:
> Magosányi, Tresys has developed (and is continuing to develop) a number
> of tools for analyzing SELinux policy. These tools are included in the
> SELinux distribution, and are also available from www.tresys.com: apol is
> the primary policy analysis tool; sepcut allows
> you to look at the various policy files and directories; seuser assists in
> managing users on an SELinux system.

Just as an aside, the Tresys setools aren't yet included in the new
userland tree for the 2.6-based SELinux and the new 2.4-based SELinux
(back port of the 2.6-based SELinux).  They still need to be transferred
over to the new tree and the Makefiles might need a little adjustment,
since everything is now installed into standard locations rather than
under /usr/local/selinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
