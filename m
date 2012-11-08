Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA8FoV7c021135
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2012 10:50:31 -0500
Received: by mail-gh0-f181.google.com with SMTP id z22so626388ghb.12
        for <selinux@tycho.nsa.gov>; Thu, 08 Nov 2012 07:49:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121108082623.GA5059@gaara.hadrons.org>
References: <20121108082623.GA5059@gaara.hadrons.org>
Date: Thu, 8 Nov 2012 10:49:59 -0500
Message-ID: <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com>
Subject: Re: Possible issues with dpkg SELinux support
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-dpkg@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 8, 2012 at 3:26 AM, Guillem Jover <guillem@debian.org> wrote:
> Hi!
>
> I've had on my TODO for some time to clear out some doubts about the
> current dpkg SELinux support (which preceded my time), to be able to
> fix some possible issues with it, and because I've never actually used
> a SELinux enabled system and my knowledge about it is mostly
> superficial. So here goes:
>
> An error from the lsetfilecon_raw() call in [0] does not currently
> end up in the installation process aborting (just an error message
> printed out), I think this is wrong as I noted with the XXX there,
> but I'd like your input on this, in case it actually needs to proceed
> anyway. Otherwise I'd guess at least ENOTSUP should be ignored.
>
>   [0] <http://anonscm.debian.org/gitweb/?p=dpkg/dpkg.git;a=blob;f=src/archives.c;h=4e363474607bd916813ce772b1e5c4c7359a76fc;hb=HEAD#l479>
>
> And when invoking package maintainer scripts, dpkg does not set a
> new execution context, like rpm does with rpm_execcon(), and while
> skimming over the SELinux policy related to dpkg it seemed like
> dpkg would need to do so.
>
> I'd be fixing those, if needed, for dpkg 1.17.x.

Agree that lsetfilecon failure other than EOPNOTSUPP should abort
package installation if SELinux is enabled.  Note that matchpathcon
and friends are deprecated interfaces; consider converting to
selabel_open and friends instead, as has already been done in rpm.
Some mechanism to allow package scriptlets to run in a different
context than the package manager would be helpful, but rpm_execcon()
may not be a very good example.  The Tizen folks have been working on
a more general architecture for rpm security plugins that may be
relevant/helpful as a guide, see prior discussions on selinux list and
rpm-maint.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
