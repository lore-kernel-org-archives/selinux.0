Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MLROWt006297
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:27:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9MLRAIS027389
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:27:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9MLRADc027386
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:27:10 GMT
Subject: Re: [PATCH] checkpolicy/policy_scan.y
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031022211407.GC4671@hydra.joerghoh.de>
References: <20031022175608.GB4531@hydra.joerghoh.de>
	 <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022190241.GA4671@hydra.joerghoh.de>
	 <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022211407.GC4671@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066858032.32228.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 17:27:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-22 at 17:14, Joerg Hoh wrote:
> with your patch:
> yacc -d policy_parse.y
> cc -g  -Wall -O2 -pipe -include global.h -I. -Iinclude -o y.tab.o -c y.tab.c
> y.tab.c: In function `yyparse':
> y.tab.c:1513: warning: implicit declaration of function `yylex'
> policy_parse.y: In function `define_te_avtab':
> policy_parse.y:2031: warning: large integer implicitly truncated to unsigned type

I've merged this patch with the ~0UL -> ~0U fix.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
