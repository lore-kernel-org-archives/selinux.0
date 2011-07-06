Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66ClInW022022
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 08:47:18 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p66ClFuO002364
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 12:47:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Subject: Re: Best base policy to use
Date: Wed, 6 Jul 2011 18:10:56 +1000
Cc: selinux <selinux@tycho.nsa.gov>
References: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
In-Reply-To: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201107061810.56632.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Jul 2011, Jeremiah Jahn <jeremiah@goodinassociates.com> wrote:
> So I'm in the process of Upgrading my servers from RHEL5 to RHEL6. On my
> RHEL5 system I had to build the reference policy from scratch in order to
> prevent users from being able to  transition to init_t through initrc_t.
> Basically, I want systems that have to be rebooted in order to restart
> certain services, like auditd, or at least be able to split those duties
> into different roles. One role can edit a file or install something, but a
> different role must restart it. Because life the universe and everything
> goes through initrc_t, just about anything on the system running as root
> can mess with services. I'd like to highly limit things, and
> haven't  really looked at any new developments in selinux for about 4
> years. What's the best way/place to start removing domain transitions and
> requiring additional roles.

When you are talking about "just about anything on the system running as root" 
are you referring to processes run as part of a system start script or a root 
login shell?

In the former case if you want to prevent the init.d script from daemon A from 
messing with daemon B (which is a real concern as some of the init.d scripts 
access data written by the daemon and could potentially be subverted) then one 
option would be to have the init.d script run in the context of the daemon.

In the latter case you could prevent a transition from sysadm_t to initrc_t 
without significant modifications to the policy, but you still need ways for 
the sysadm to restart daemons.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
