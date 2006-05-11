Subject: Re: pam_namespace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rogelio Serrano <rogelio.serrano@gmail.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <a9951d2a0605110645v42cb9987ucb697d866cae8960@mail.gmail.com>
References: <200605051623.25533.russell@coker.com.au>
	 <a9951d2a0605110645v42cb9987ucb697d866cae8960@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 11 May 2006 09:57:01 -0400
Message-Id: <1147355821.17252.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-11 at 21:45 +0800, Rogelio Serrano wrote:
> separate namespaces is somewhat similar to selinux/dte and clashes
> with it. i dont think we can mix selinux with separate namespaces as
> it is right now.

I think there is a misunderstanding - Linux namespaces do not
clash/conflict with SELinux at all, and pam_namespace is a mechanism for
using Linux namespaces and bind mounts to provide similar functionality
to multi-level directories in SELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
