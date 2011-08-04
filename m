Subject: Re: SELinux policy regarding LD_LIBRARY_PATH
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aaron Sowry <aaron@cendio.se>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E3A8D16.7060807@cendio.se>
References: <4E3A8D16.7060807@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 09:09:25 -0400
Message-ID: <1312463365.20973.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-04 at 14:14 +0200, Aaron Sowry wrote:
> Hi,
> 
> It appears that with SELinux enabled, the LD_LIBRARY_PATH environment
> variable is not inherited by user processes forked by a root process.
> This is on RHEL6.
> 
> What is the general SELinux policy regarding LD_LIBRARY_PATH? Is there
> any way to change this behaviour? I couldn't find any documentation
> regarding this.

I see that Sven has answered your question, but wanted to clarify one
point:  this behavior happens on execve, not on fork, and only if the
process security context changes (whether an automatic transition or
explicit request by the caller via setexeccon prior to execve).

However, the behavior you are seeing might not be related to SELinux, as
Linux also enables AT_SECURE if the uid or gid changes across execve (to
be precise, if the effective identity is not equal to the real identity
after the credential change, as this was the legacy logic from libc).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
