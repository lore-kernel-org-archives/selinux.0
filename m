Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6NMREdO001399
 for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2016 18:27:14 -0400
Received: from home ([69.58.4.58]) by mail.gmx.com (mrgmx002) with ESMTPSA
 (Nemesis) id 0LptId-1andUq2vqh-00fkUT for <selinux@tycho.nsa.gov>; Sun, 24
 Jul 2016 00:27:08 +0200
Date: Sat, 23 Jul 2016 22:27:04 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: genhomedircon: some issues with a custom policy
Message-ID: <20160723222704.GB29599@home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

There are a few issues I've run into with genhomedircon and a custom policy
(i.e., not based on refpolicy), 2 of which prevent me from using genhomedircon,
and 1 small issue which I can work around.

The first main issue is that my custom policy doesn't use "system_u" as the
system user identifier (instead it is "sys.id").  So when genhomedircon writes
out contexts for my login they are still associated with sys.id because
genhomedircon only does a simple search and replace for the default refpolicy
system user identifier "system_u".  I had look at existing contexts in
homedir_templates for refpolicy, fedora-selinux and the custom policy I'm using
and it seems like it'd be safe enough to replace the SELinux user in all the
HOMEDIR and USER context specifications regardless of if it matches "system_u".
Would this be a reasonable approach?

The second issue is RBACSEP in my policy.  There's currently no way for
genhomedircon to know which role to associate with a logins file context specs
if RBACSEP is used.  I noticed that genhomedircon will replace "ROLE" in context
specs with whatever the SELinux users prefix is so I've currently hacked
genhomedircon.c to replace the role in each context with whatever the users
prefix is and have some policy like this:

(in wheel
    (tunableif enable_rbacsep
        (true
            (userprefix id wheel.role))))

This makes sure all logins associated with wheel.id get a role of "wheel.role"
in their generated context specs. This seems like a bit of a hack since
historically the users prefix has been used for a prefix in a type identifier.
Any suggestions on how this should be handled?

The third and smallest issue is that semanage-login supports login identifiers
with the %groupname format but genhomedircon doesn't expand them to the groups
members.  I currently expand groups to their members in genhomedircon and treat
a user belonging to 2 groups listed in seusers as an error.  Would a patch be
accepted for this functionality?

Thanks,
Gary.
