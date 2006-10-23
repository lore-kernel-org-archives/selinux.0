Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NIfdB6015897
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 14:41:39 -0400
Received: from web36602.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9NIesfU019875
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 18:40:54 GMT
Message-ID: <20061023184140.12138.qmail@web36602.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 11:41:40 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <453CF1A5.5020200@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Paul Moore <paul.moore@hp.com> wrote:

> Casey Schaufler wrote:
> > 
> > --- James Antill <jantill@redhat.com> wrote:
> > 
> >>On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley
> >>wrote:
> >> 
> >>>That doesn't address sshd though.  Or gdm.  sshd
> >>shouldn't be too difficult.
> >>
> >> Combined with adding similar code to sshd.
> > 
> > 
> > Just a heads up, you want to do this, but
> > you may not be able to get an evaluation team
> > to allow it in an evaluated configuration.
> 
> Okay, I'm curious so I'll bite - why not, what
> problems would you expect?

I'm talking strictly from an MLS viewpoint here,
mind you. If y'all are using TE as a security
mechanism in your evaluation you'll have to
deal with that as well. Anywho ...

If you are treating your network as a single
level device and allow logins (e.g. via ssh)
at labels other than that configured to the
device you are violating the MLS policy on
the device. A TopSecret login on a device
configured to be Confidential can not be
permitted because TopSecret information,
such as the command prompt, cannot be sent
to the Confidential device.

If you are treating the network as a multi
level device the communications will take
place at a label passed along with (or beside)
the packets. Changing the label of the process
will prevent it from going out through the
established connection. If you could, you'd
be able to pass TopSecret information in
packets marked Confidential, again a Bad Thing.

If you are treating each packet as a labeled
entity and the network environment irrelivent
and you don't change how the packets are labeled
when you change the process label you are not
properly labeling them. If you do change the
labeling of the packets and let them through
anyway you're not enforcing MLS policy.

You can treat the network as a device, an import/
export mechanism, or an internal communication
mechanism but you can't get away from the fact
that when a process changes its MLS properties
it can't use the communication channels it was
using with the old properties. Unless the
communication channels don't enforce policy,
in which case your system isn't enforcing
MLS policy everywhere required.

I understand that this is not the case with TE.
I am very curious how domain transitions are
going to play out in an evaluation. The process
should be educational.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
