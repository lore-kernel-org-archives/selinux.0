Subject: Re: help,sshd, nlmsg_relay
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul S <nnm.one@gmail.com>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <9e8747560706041536w668b0d58wb02dec03c86c8da4@mail.gmail.com>
References: <9e8747560706041536w668b0d58wb02dec03c86c8da4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:49:54 -0400
Message-Id: <1181047794.25769.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 00:36 +0200, Paul S wrote:
> Hi, 
> 
> When I try to connect to my sshd from LAN, when in enforcing more, I
> get permission denied after typing in the password on the client.
> I tried pinpointing the problem but I can't seem to compile and use a
> module for sshd from the AVC messages. I used "cat /var/log/messages |
> audit2allow -l -M local" and when installing the module I get lots of
> assertions, so here's the sshd parts: 
> 
> -------------------------------------------------------------------------------------------------------------
> [root@area51 sshd]# cat MYsshd.te
> module MYsshd 1.0;
> 
> require {
>         type staff_t;
>         type user_home_dir_t;
>         type sshd_t;
>         class file { write ioctl };
>         class capability { audit_control audit_write };
>         class netlink_audit_socket { create nlmsg_relay write read }; 
> }
> 
> #============= sshd_t ==============
> allow sshd_t self:capability { audit_control audit_write };
> allow sshd_t self:netlink_audit_socket { create nlmsg_relay read
> write };

These seem to be showing up lately - file a bug against the policy, as
they should already be allowed.

You can allow them by replacing those two allow rules with the following
line:
	logging_send_audit_msg(sshd_t)
> 
> #============= staff_t ============= 
> allow staff_t user_home_dir_t:file { write ioctl };
> 
> -------------------------------------------------------------------------------------------------------------
> [root@area51 sshd]# semodule -i MYsshd.pp 
> libsepol.check_assertion_helper: assertion on line 0 violated by allow
> sshd_t sshd_t:netlink_audit_socket { nlmsg_relay };
> libsepol.check_assertion_helper: assertion on line 0 violated by allow
> sshd_t sshd_t:capability { audit_write }; 
> libsepol.check_assertion_helper: assertion on line 0 violated by allow
> sshd_t sshd_t:capability { audit_control };
> libsepol.check_assertions: 3 assertion violations occured
> libsemanage.semanage_expand_sandbox: Expand module failed 
> semodule:  Failed!
> 
> -------------------------------------------------------------------------------------------------------------
> 
> 
> thnx
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
