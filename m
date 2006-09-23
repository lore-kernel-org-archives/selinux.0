Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8NME1xm027680
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 18:14:03 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8NMDOFR023336
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 22:13:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: FC5 policy
Date: Sun, 24 Sep 2006 08:13:54 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
References: <200609240034.08217.russell@coker.com.au> <45154AC3.6040109@gentoo.org>
In-Reply-To: <45154AC3.6040109@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609240813.56907.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 24 September 2006 00:54, Joshua Brindle <method@gentoo.org> wrote:
> Russell Coker wrote:
> > http://www.coker.com.au/selinux/fc5/
> >
> > At the above URL I have my latest packages of FC5 policy with patch and
> > source.  They compile the policy with amavis and clamav policy in base
> > (which can't be included in an FC5 update as the tools are broken and
> > don't support policy moving from a module to base), they have Postgrey
> > policy compiled in, and they have a few other policy changes (such as
> > allowing unconfined_t to kill unlabeled_t processes).
>
> um? in what way are the tools broken? It is quite easy to move a module
> to base:
>
> semodule -r clamav -i base-with-clamav.pp

The package installation process can't do it.

Ideally we would have some way for semodule to automatically figure out that 
base-with-clamav.pp has the clamav module and do the right thing.

> > Also my patch removes some unnecessary and inappropriate access from some
> > domains.  I know that most people don't like removing access from
> > processes, but I think we need to use the principle of least-privilege
> > more seriously.
>
> Who doesn't like removing access from processes? I think we are all on
> the same side here..

Then why do I keep sending this patch to the list and it doesn't get applied?

Why hasn't the pre-fedora /boot sym-links thing been cleaned up?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
