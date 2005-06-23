Subject: Re: sshd policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200506231632.32753.russell@coker.com.au>
References: <200506231632.32753.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 08:21:35 -0400
Message-Id: <1119529295.28493.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:32 +1000, Russell Coker wrote:
> I have attached the source files and the diff for a change to the way sshd 
> works.
> 
> Recent versions of OpenSSH by default will re-exec the sshd as part of the 
> login process.  This means that there is no need for one process to have all 
> the permissions that sshd is usually granted.  So I have split up the sshd 
> policy into two domains, one of which listens on the port and the other does 
> most of the sshd work.

How does sshd respond to SIGHUP?  Also a re-exec?  If so, then this
could be problematic, as it would transition domains on the initial
daemon incorrectly, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
