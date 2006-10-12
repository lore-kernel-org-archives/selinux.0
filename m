Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CGsGOs001390
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 12:54:16 -0400
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9CGqvYP013317
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 16:52:58 GMT
Message-ID: <20061012165415.64473.qmail@web36611.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 09:54:15 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
To: Klaus Weidner <klaus@atsec.com>, Russell Coker <russell@coker.com.au>
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <20061012144819.GF28520@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Klaus Weidner <klaus@atsec.com> wrote:


> I don't think that it's a significant issue though
> for current LSPP
> configurations - any people who plan to use this
> please speak up if you
> disagree.  The current LSPP configurations are for
> server systems,

A common deployment of an MLS system is the
the enormous compute "server", where users
log in at various MLS values to process
data, some of which is common, and some of
which is not. Usually this means a network
login, today typically using ssh. Rarely
will a user need to log in at more than one
MLS value, but it can (and has) happened
that a user will have multiple valid MLS
values. In some installations they will want
to allow this over "unlabeled networks",
and in some they will not.

> and
> require that local consoles (including serial
> consoles listed in
> /etc/securetty) are physically restricted to be
> accessible by admins
> only, and admins can still use newrole. This leaves
> only non-admin serial
> terminals, and I don't think those are that common
> these days.

Indeed!

> Of course, people deploying a system that's based on
> the LSPP
> configuration can choose to deviate from the
> evaluated configuration
> based on their own risk assessment. This could
> include restoring general
> access to "newrole" if they don't consider the PTY
> exploit to be a
> concern.

It might be best if you don't say that out loud.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
