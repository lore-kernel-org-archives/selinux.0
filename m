From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: New policy diff
Date: Thu, 30 Sep 2004 00:14:54 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <415AAE8C.5050102@redhat.com>
In-Reply-To: <415AAE8C.5050102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409300014.54730.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Sep 2004 22:46, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Added policy for vpnc.
> Mailman location on redhat is changing.
> More fixes for xinetd apps

can_exec(hotplug_t, hostname_exec_t)
dontaudit hostname_t hotplug_t:fd { use };

If hostname_exec_t is executed in domain hotplug_t then the dontaudit rule 
will never be needed.

+usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t

Typo, missing leading '/'.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
