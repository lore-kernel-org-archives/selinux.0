Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NGdJwj011096
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 12:39:19 -0400
Received: from web36604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9NGboOG014699
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 16:37:50 GMT
Message-ID: <20061023163904.67183.qmail@web36604.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 09:39:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
To: James Antill <jantill@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        russell@coker.com.au, selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161620097.667.10.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- James Antill <jantill@redhat.com> wrote:

> On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley
> wrote:
> 
> > pam_selinux used to have support to let the user
> pick from the list of
> > reachable contexts for the user.  So you could
> just restore that
> > support.
> 
>  So, in summary of the discussion, having
> pam_selinux let the user pick
> the TE and Sensitivity separately (much as it does
> now if
> get_ordered_context_list_with_level() fails) is the
> valid approach?

On Trix you can specify the MAC and Capabilities
this way, so it seems you ought to be able to
specify Sensitivity and TE on SELinux.

> > That doesn't address sshd though.  Or gdm.  sshd
> shouldn't be too
> > difficult.
> 
>  Combined with adding similar code to sshd.

Just a heads up, you want to do this, but
you may not be able to get an evaluation team
to allow it in an evaluated configuration.

> >   There were some externally developed gdm patches
> for selinux
> > that enabled context selection long ago, but
> nothing recent
> > (pre-Fedora).
> 
>  But, from the "gdm/trsuted-X needs lots more work"
> discussion, gdm
> should just stay with the default Sensitivity and
> people can use a
> terminal+ssh to change levels?

The MLS-ignorant Xserver should not be able to
communicate with clients run with a different MLS
value, but this trick ought to work, providing
further assurance that allowing the option to
specific MLS value when you login (ssh) over a
network connection won't get past the evaluators.
Plus, it will only work for terminals, not
for launching X clients.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
