Subject: Re: Linux user / SELinux user changes...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D03ABC378@de01exm68.ds.mot.com>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
	 <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil>
	 <20070620201333.GC32520@sergelap.austin.ibm.com>
	 <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil>
	 <20070620210835.GA21869@sergelap.austin.ibm.com>
	 <1182428692.15064.277.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D03ABC378@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 07:36:28 -0400
Message-Id: <1182512188.24664.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 21:29 -0400, Hasan Rezaul-CHR010 wrote:
>  Hi All,
> 
> If I have Linux users "root"  and "test"     and I have
> SELinux users  "staff_u", and "user_u",  and 
> SELinux roles  "staff_r", and "user_r"  
> 
> If I ssh into the Linux machine as test, my SELinux identity is user_u.
> If I ssh into the Linux machine as root, my SELinux identity is staff_u.
> 
> Lets say I ssh into my Linux machine as Linux user "root".
> "id -Z"  shows   staff_u:staff_r:staff_t
> 
> Now if I downgrade my Linux user priviledge to user "test" by using  su
> as follows:
> 
> su - test
> Pass: test
> 
> id -Z  =>  still shows me that I am staff_u , even though I am Linux
> user "test" (Linux user test should ideally be mapped to user_u).
> 
> Is there a way for SELinux to automatically adjust/change the SELinux
> user, whenever the Linux user is changed via "su"  ???

In original SELinux, we intentionally chose to not change SELinux user
identity upon su; the SELinux user identity was established upon login
session creation and served as a fixed bound on the potential set of
security contexts that the user could enter for the entire session
(using newrole to change roles).

In early Fedora and RHEL (Fedora < 5?, RHEL 4) SELinux, Red Hat chose to
integrate su with SELinux by putting pam_selinux into /etc/pam.d/su.
But they later reverted that - it caused more problems than it solved.
So modern Fedora and RHEL 5 have the original SELinux behavior of
keeping them separated.

You could put pam_selinux into /etc/pam.d/su (see /etc/pam.d/login for
an example) and change your policy to allow that (see the
ifdef(`distro_rhel4' blocks in policy/modules/admin/su.if), but that
would deviate from current standard practice.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
