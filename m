Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8EDsOK7029421
	for <selinux@tycho.nsa.gov>; Sat, 14 Sep 2013 09:54:24 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so1126228ead.31
        for <selinux@tycho.nsa.gov>; Sat, 14 Sep 2013 06:54:22 -0700 (PDT)
Message-ID: <1379166860.4313.21.camel@d30>
Subject: RFC policycoreutils packaging
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Sat, 14 Sep 2013 15:54:20 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We were discussing policycoreutils packaging and there are some things
unclear to me:

1. if one wants to run a monotlitic policy on a embedded system, then,
besides fixfiles and checkpolicy, which tools from policycoreutils are
needed?

1.a How are home dir contexts generated with monolithic policy (  or
should they be created manually ? ), i ask this because in Fedora the
genhomedircon is just a script that calls semodule, but i think semodule
does not work with monolithic policy. If true, how then is someone
expected to generate home dir contexts?

2. Does the sandbox utility only work ( or only work properly ) in
policy configurations that have the MCS security model enabled? If so
should one then depend on a policy model that has MCS enabled?

Fedora splits policycoreutils into the following components/packages:

policycoreutils
policycoreutils-devel
policycoreutils-gui
policycoreutils-newrole
policycoreutils-python
policycoreutils-restorecond
policycoreutils-sandbox

However i am considering whether it makes sense to additionally split
policycoreutils into policycoreutils, and policycoreutils-semodule. 

Because well monlithic configurations do not need semodule.

The problem here is that genhomedircon is basically a shell script that
runs semodule, thus i suspect that the genhomedircon script then needs
to also go into the policycoreutils-semodule package.

Then i get back to my first question, if semodule generates
homedircontexts, and cannot be used with monolithic policy, and if
genhomedircon is just a shell script that runs semodule, then how does
one take care of home dir contexts in a monolithic configuration?

Any hints, tips advice and comments are greatly appreciated.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
