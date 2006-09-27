From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Bug in 2.6.18: read of /proc/$PID/exe triggers ptrace check
Date: Thu, 28 Sep 2006 08:36:25 +1000
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        SELinux ML <selinux@tycho.nsa.gov>
References: <20060927165234.GA5448@warschau.cip.ifi.lmu.de> <1159378484.2260.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159378484.2260.27.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609280836.28774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 September 2006 03:34, Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> One option would be to define a ptrace_may_read() function to
> distinguish reading process state from full ptrace attach, and then
> change proc_fd_access_allowed() and proc_pid_environ() to call the new
> function instead of ptrace_may_attach().  Internally, that function

The name ptrace_may_read() implies that it permits unconditional ptrace read 
access (IE read the entire address space of the process), so it doesn't seem 
like a good name for this.  Maybe ptrace_may_read_state() would be a better 
name.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
