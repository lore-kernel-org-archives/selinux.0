Date: Tue, 4 Mar 2008 14:26:20 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200803041926.m24JQKmi010144@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: avoid -Werror for parser-generated sources
Cc: jbrindle@tresys.com, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As alluded to the other day, I have a large patch to checkpolicy.

The changes are purely mechanical.  Everything but the yacc rules has
been moved from policy_parse.c into policy_define.c and policy_define.h.
This allows us to retain strict error checking (-Werror) on the SELinux
toolchain without our being tripped up by generated (yacc/bison) code.

The diff is over the list limit and is not really something that can 
be broken up further so I've put it up for download at:
    http://www.gratisoft.us/todd/policy_define.diff

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 Makefile        |    3
 policy_define.c | 3831 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 policy_define.h |   58
 policy_parse.y  | 3839 --------------------------------------------------------
 4 files changed, 3895 insertions(+), 3836 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
