Date: Mon, 31 Jul 2006 16:59:54 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 1/2] kernel support for new range_transition statements
In-Reply-To: <1154361018.1447.106.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0607311659360.3463@d.namei>
References: <44CA2956.8050609@trustedcs.com> <1154361018.1447.106.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 31 Jul 2006, Stephen Smalley wrote:

> On Fri, 2006-07-28 at 10:12 -0500, Darrel Goeddel wrote:
> > This patch introduces support for policy version 21.  This version of the
> > binary kernel policy allows for defining range transitions on security
> > classes other than the process security class.  As always, backwards
> > compatibility for older formats is retained.  The security class is read in as
> > specified when using the new format, while the "process" security class is
> > assumed when using an older policy format.
> > 
> > Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
