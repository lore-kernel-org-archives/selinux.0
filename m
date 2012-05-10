Subject: Re: execute system-config-selinux while enforcing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4FABBCA4.8090006@rubix.com>
References: <4FABBCA4.8090006@rubix.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 May 2012 09:17:27 -0400
Message-ID: <1336655847.8705.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-05-10 at 15:03 +0200, Andy Warner wrote:
> I am running Scientific Linux 6.0, fully updated using the targeted
> policy. 
> 
> Is there a method to execute the SELinux admin GUI tool
> system-config-selinux while in enforcing mode of the targeted policy? 
> 
> My assumption is that root linux user combined with sysadm_r role
> would work. However, after creating a shell with sudo -i -r sysadm_r
> (from the staff_r role), the tool fails to start. I then tried to
> create a user that would login via the GUI login and receive the
> sysadm_r role by default. In this case I was unsuccessful in even
> getting the sysadm_r role to have the sysadm_t upon login. It receives
> a context of sysadm_u:sysadm_r:oddjob_mkhomedir_t. This despite having
> the following /etc/selinux/targeted/contexts/users/sysadm_u file:
> 
> system_r:local_login_t:s0    sysadm_r:sysadm_t:s0
> system_r:remote_login_t:s0    sysadm_r:sysadm_t:s0
> system_r:sshd_t:s0        sysadm_r:sysadm_t:s0
> system_r:crond_t:s0        sysadm_r:sysadm_t:s0
> system_r:xdm_t:s0        sysadm_r:sysadm_t:s0
> sysadm_r:sysadm_su_t:s0        sysadm_r:sysadm_t:s0
> sysadm_r:sysadm_sudo_t:s0    sysadm_r:sysadm_t:s0
> system_r:initrc_su_t:s0        sysadm_r:sysadm_t:s0
> sysadm_r:sysadm_t:s0        sysadm_r:sysadm_t:s0
> sysadm_r:sysadm_su_t:s0        sysadm_r:sysadm_t:s0 
> sysadm_r:sysadm_sudo_t:s0    sysadm_r:sysadm_t:s0

Under targeted policy, wouldn't you run it from an
unconfined_u/unconfined_r login?  Which would be the default for users
who haven't been mapped to a specific role via semanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
