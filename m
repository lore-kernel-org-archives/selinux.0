Subject: Re: how to test ssh_sysadm_login(tunable)
From: Erich Schubert <erich@debian.org>
To: Jian Liu <gjk.liu@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <8c2dc7030612030114l4da1eff4ma21492aa5a325664@mail.gmail.com>
References: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com>
	 <200612012117.52567.russell@coker.com.au>
	 <8c2dc7030612030114l4da1eff4ma21492aa5a325664@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 15:27:12 +0100
Message-Id: <1165156032.4758.10.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Jian Liu,
> But, after "ssh_sysadm_login" is set to on, there is
> not a login menu containing

I believe the role selection menu on login has been removed some time
ago. It will log you into the first role you have access to. I think the
file was default_contexts. So if you want to login as sysadm_r by
default you need to change this file, otherwise use "newrole" to switch
roles (which is not really more effort than the login menu)

I'm not sure about the rationale, but I could imagine some applications
using ssh to login were confused by the extra prompt or so.

Just my vague memories, it might be completely off.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  There is no branch of mathematics, however abstract, which may not  //\
 some day be applied to phenomena of the real world. --- Lobatchevsky V_/_
             Es ist besser, geliebt und verloren zu haben,
                     als niemals geliebt zu haben.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
