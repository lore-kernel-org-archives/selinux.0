Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA88QqZl027275
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2012 03:26:52 -0500
Date: Thu, 8 Nov 2012 09:26:23 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org, debian-dpkg@lists.debian.org
Subject: Possible issues with dpkg SELinux support
Message-ID: <20121108082623.GA5059@gaara.hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I've had on my TODO for some time to clear out some doubts about the
current dpkg SELinux support (which preceded my time), to be able to
fix some possible issues with it, and because I've never actually used
a SELinux enabled system and my knowledge about it is mostly
superficial. So here goes:

An error from the lsetfilecon_raw() call in [0] does not currently
end up in the installation process aborting (just an error message
printed out), I think this is wrong as I noted with the XXX there,
but I'd like your input on this, in case it actually needs to proceed
anyway. Otherwise I'd guess at least ENOTSUP should be ignored.

  [0] <http://anonscm.debian.org/gitweb/?p=dpkg/dpkg.git;a=blob;f=src/archives.c;h=4e363474607bd916813ce772b1e5c4c7359a76fc;hb=HEAD#l479>

And when invoking package maintainer scripts, dpkg does not set a
new execution context, like rpm does with rpm_execcon(), and while
skimming over the SELinux policy related to dpkg it seemed like
dpkg would need to do so.

I'd be fixing those, if needed, for dpkg 1.17.x.

thanks,
guillem

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
