From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: how to test ssh_sysadm_login(tunable)
Date: Mon, 4 Dec 2006 08:17:34 +1100
Cc: Jian Liu <gjk.liu@gmail.com>, SELinux@tycho.nsa.gov
References: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com> <8c2dc7030612030114l4da1eff4ma21492aa5a325664@mail.gmail.com> <1165156032.4758.10.camel@hepcat.vitavonni.de>
In-Reply-To: <1165156032.4758.10.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612040817.37685.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 December 2006 01:27, Erich Schubert <erich@debian.org> wrote:
> > But, after "ssh_sysadm_login" is set to on, there is
> > not a login menu containing
>
> I believe the role selection menu on login has been removed some time
> ago. It will log you into the first role you have access to. I think the
> file was default_contexts. So if you want to login as sysadm_r by
> default you need to change this file, otherwise use "newrole" to switch
> roles (which is not really more effort than the login menu)
>
> I'm not sure about the rationale, but I could imagine some applications
> using ssh to login were confused by the extra prompt or so.

The PAM module used for /bin/login gave a prompt (if configured for it) and 
the sshd patch allowed logins of the form bar/staff_r@host to login to 
account "bar" with role "staff_r" on the host in question.

I plan to revive this for Debian.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
