Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MLDZWt006185
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:13:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9MLDYIE011169
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:13:35 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h9MLDX1J011166 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:13:34 GMT
Date: Wed, 22 Oct 2003 23:14:08 +0200
From: Joerg Hoh <joerg@devone.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] checkpolicy/policy_scan.y
Message-ID: <20031022211407.GC4671@hydra.joerghoh.de>
References: <20031022175608.GB4531@hydra.joerghoh.de> <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil> <20031022190241.GA4671@hydra.joerghoh.de> <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 22, 2003 at 04:44:57PM -0400, Stephen Smalley wrote:
> Below is a modified form of your patch that seeks to preserve the
> distinction between val and ptr and introduces a valptr for the
> uintptr_t case.  Let me know if you see warnings with this patch that
> you do not see with your patch. 

The original warnings:
yacc -d policy_parse.y
cc -g  -Wall -O2 -pipe -include global.h -I. -Iinclude -o y.tab.o -c y.tab.c
y.tab.c: In function `yyparse':
y.tab.c:1511: warning: implicit declaration of function `yylex'
policy_parse.y: In function `define_cexpr':
policy_parse.y:2644: warning: cast from pointer to integer of different size
policy_parse.y:2645: warning: cast from pointer to integer of different size
policy_parse.y:2648: warning: cast from pointer to integer of different size
policy_parse.y:2649: warning: cast from pointer to integer of different size

with your patch:
yacc -d policy_parse.y
cc -g  -Wall -O2 -pipe -include global.h -I. -Iinclude -o y.tab.o -c y.tab.c
y.tab.c: In function `yyparse':
y.tab.c:1513: warning: implicit declaration of function `yylex'
policy_parse.y: In function `define_te_avtab':
policy_parse.y:2031: warning: large integer implicitly truncated to unsigned type

with my patch:
yacc -d policy_parse.y
cc -g  -Wall -W  -O2 -pipe -include global.h -I. -Iinclude -o y.tab.o -c y.tab.c
y.tab.c: In function `yyparse':
y.tab.c:1512: warning: implicit declaration of function `yylex'

> Note that with either patch, warnings
> will still occur on 64bit unless you have also patched your constraint.h
> to use uintptr_t for the fields of the constraint_expr structure, but
> that is not acceptable as it changes the binary policy format (or it
> would, if the write.c code were also adjusted correspondingly, and it
> serves no purpose otherwise). 

I will try it tomorrow.

Joerg

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
