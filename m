Subject: Re: python execv 'self:fd use' AVC for fd to /lib64/ld-2.8.so
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <cadfc0e40811201441r223561det3dd24c42066642e0@mail.gmail.com>
References: <cadfc0e40811201441r223561det3dd24c42066642e0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 09:00:59 -0500
Message-Id: <1227276059.7319.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-11-20 at 16:41 -0600, Xavier Toth wrote:
> I'm getting the following MLS constraint violation:
> 
> node=comms type=AVC msg=audit(1227219700.656:22127): avc:  denied  {
> use } for  pid=30685 comm="getselection" path="/lib64/ld-2.8.so"
> dev=dm-0 ino=8282255
> scontext=user_u:user_r:user_securecp_t:s3:c0,c2,c11,c200.c511
> tcontext=user_u:user_r:user_securecp_t:s0-s15:c0.c1023 tclass=fd
> 
> when execing a child process at a different level. I have code that
> sets FD_CLOEXEC on all valid fds so I'm confused as to why this is
> happening and what to do about it. Any ideas?

See:
http://marc.info/?l=selinux&m=118780002121536&w=2
http://marc.info/?l=selinux&m=118781007404156&w=2

Eric & James - as noted in the above, we may want to explore changing
the kernel logic.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
