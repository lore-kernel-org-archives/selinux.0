Subject: Re: Service control via /etc/init.d/ using strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eoin Ryan <ryaneoin@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <207608340802041008o6c9c39a7l491f013a4becd233@mail.gmail.com>
References: <207608340802041008o6c9c39a7l491f013a4becd233@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 13:45:30 -0500
Message-Id: <1202150730.3070.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 18:08 +0000, Eoin Ryan wrote:
> Hi All,
> 
> Apologies in advance if this is slightly off topic.  Over the last few
> years I've gained some experience with SELinux using the targeted
> policy, but now after discovering the new support in RHEL5 I've
> decided to learn about the strict/mls policies and hopefully
> contribute in some way one day.
> 
> I have a test RHEL5 system running the strict policy, but I'm confused
> about how services/daemons can be controlled by the superuser.  The
> sysadm_t does not have permission to execute initrc_exec_t, but does
> have permission to execute /usr/sbin/httpd directly as it's
> httpd_exec_t.  The type_transition rules allow mainly the system
> startup types (init_t etc) to transition to initrc_exec_t, but there
> is no transition from sysadm_t defined.  This seems to say that
> services can only be started and stopped during bootup and shutdown.
> 
> Am I missing something here, or does a transition to initrc_exec_t
> need to be defined for some SELinux user via a policy module?  Sorry
> if my terminology is a little off.

Depends on your policy build settings.  If DIRECT_INITRC was set to n in
build.conf, then you have to use run_init to run init scripts from an
admin shell, so you can do:
	run_init /etc/init.d/httpd restart

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
