Date: Thu, 28 Jun 2012 12:56:29 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SELinux@tycho.nsa.gov
Subject: setools FTBFS in python module
Message-ID: <20120628125629.0fead796@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

setools is currently FTBFS in debian due to swig 2.0.7 with the
following error:

> ../../../libqpol/include/qpol/terule_query.h:118:13: note: previous
> declaration of 'qpol_terule_get_rule_type' was here qpol_wrap.c: In
> function 'qpol_terule_get_rule_type': qpol_wrap.c:4888:3: warning:
> passing argument 1 of 'qpol_terule_get_rule_type' from incompatible
> pointer type [enabled by default] qpol_wrap.c:4885:16: note: expected
> 'struct qpol_terule *' but argument is of type 'struct qpol_policy_t
> *' qpol_wrap.c:4888:3: warning: passing argument 2 of
> 'qpol_terule_get_rule_type' from incompatible pointer type [enabled
> by default] qpol_wrap.c:4885:16: note: expected 'struct qpol_policy_t
> *' but argument is of type 'struct qpol_terule *' qpol_wrap.c:4888:3:
> error: too many arguments to function 'qpol_terule_get_rule_type'
> qpol_wrap.c:4885:16: note: declared here qpol_wrap.c: At top level:
> qpol_wrap.c:4895:31: error: conflicting types for
> 'qpol_terule_get_source_type' In file included
> from ../../../libqpol/include/qpol/policy.h:60:0,
> from ../../../libqpol/include/../include/qpol/avrule_query.h:34, from
> qpol_wrap.c:3010:

OpenSuse is applying a patch[1] that is fixing the issue. Do you think
that this patch could be merged (as well as the other swig patch that
fix swig 2.0 detection?).

Also what is the status of setools? It seems that all the distribution
(RedHat, OpenSuse, Debian,...) are applying a bunch of other patches.
Shouldn't all these be merged? Or is setools definitely dead?

Cheers

Laurent Bigonville

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=672040
[1]
https://build.opensuse.org/package/view_file?file=setools-swig-2.0.7.patch&package=setools&project=security%3ASELinux&rev=fa0565dafcc84c3c18514867f92270a1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
