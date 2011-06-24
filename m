Subject: Re: Wrong context for user
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	 <1308920243.15355.55.camel@moss-pluto>
	 <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Jun 2011 10:11:30 -0400
Message-ID: <1308924690.15355.72.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-06-24 at 09:44 -0400, c.r.madhusudhanan@gmail.com wrote:
> Hello  Daniel, Stephen,
> 
> Thanks for the quick reply.
> 
> Yes it looks login runs in the wrong context,
> system_u:system_r:kernel_t and most of the processes are. 
> 
> I am loading selinux policies from init, so I would expect all daemons
> should show their respective contexts.
> 
> Attached is the "ps -aeZ" output.
> 
> BTW, when I do "run_init /etc/init.d/sshd restart" the context changes
> from 
> "system_u:system_r:kernel_t" to  "system_u:system_r:initrc_t" but not
> to sshd_t.

Once policy is loaded, you have to make the first transition to init_t
for the init process.  That can be done in one of several ways:

- load policy before execing /sbin/init from the real root (e.g. from
initramfs), and then you'll transition naturally when you exec
the /sbin/init binary if the file is labeled init_exec_t.  I think we
did this when using upstart in Fedora to avoid modifying upstart itself.

- load policy from within /sbin/init and then re-exec yourself, using an
environment variable or argument to only do on the first invocation.
This is what the original patches to SysVinit did in Fedora (and I think
it is what systemd does too).

- load policy from init and invoke setcon() to dynamically switch to the
init context before proceeding.  Not preferred, but possible.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
