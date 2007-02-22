Subject: Re: I think this is equivalent to what we have now and more
	efficient.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DDAA80.80603@redhat.com>
References: <45DDAA80.80603@redhat.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:45:40 -0500
Message-Id: <1172155540.14363.372.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 09:36 -0500, Daniel J Walsh wrote:
> int is_selinux_enabled(void)
> {
>     security_context_t con;
> 
>     if (getcon_raw(&con) == 0) {
>         int enabled = 1;
>         if (!strcmp(con, "kernel"))
>             enabled = 0;
>         freecon(con);
>         return enabled;

IOW, if I can read /proc/self/attr/current successfully (will fail if
SELinux disabled or under certain unrelated conditions) and its value
indicates a policy has been loaded, then SELinux is enabled.

>     } else {
>         struct stat buf;
>         return (stat("/proc/filesystems", &buf));

That won't test for selinux at all - you have to check the contents
of /proc/filesystems for selinuxfs or stat /selinux and check for the
selinux magic number as per Steve's patch.

>     }
> 
> }
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
