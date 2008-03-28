Subject: Re: Debian SE Linux status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <200803281106.47699.russell@coker.com.au>
References: <200803281106.47699.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 08:53:10 -0400
Message-Id: <1206708790.3302.414.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 11:06 +1100, Russell Coker wrote:
> http://etbe.coker.com.au/2008/03/28/debian-se-linux-status/
> 
> Those of you who don't read Planet SE Linux but who are interested in Debian 
> may want to read the above.

Regarding the mismatch in policy version between your domU vs. dom0, you
should be able to build older policy versions via the config setting
in /etc/selinux/semanage.conf (modular build) or via the OUTPUT_POLICY=
setting in build.conf, overridable on the make command line (monolithic
build).

Or you could install newer selinux core userland in your dom0 such that
it can read and downgrade the latest policy to the one supported by your
kernel (libselinux policy load logic will convert a newer policy to an
older one at load time for you).

Agree that converting between non-MLS and MLS/MCS is very painful at
present.  Part of that we can fix (inappropriate dependencies in
semanage/seobject.py that should be querying the policy store via
libsemanage/libsepol rather than checking the running policy), and part
we cannot (still won't be able to switch the kind of policy at policy
reload in the kernel).  I'd actually prefer that we just always enable
the MLS engine and field for simplification, presenting the same
experience to all users, and ensuring that we are all testing the same
code paths.  I don't know how others feel about that though - I know
that Gentoo has historically not enabled MCS/MLS, and that upstream
refpolicy still defaults to not enabling it (standard).

I'm not sure why MLS support significantly increases policy build time
though.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
