Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NL4DWt012238
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 17:04:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9NL3xIS017690
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:03:59 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9NL3wDc017684
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:03:58 GMT
Date: Thu, 23 Oct 2003 23:04:10 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] checkpolicy/policy_scan.y
Message-ID: <20031023210410.GA21631@wavehammer.waldi.eu.org>
References: <20031022175608.GB4531@hydra.joerghoh.de> <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil> <20031022190241.GA4671@hydra.joerghoh.de> <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil> <20031022211407.GC4671@hydra.joerghoh.de> <1066858032.32228.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FsscpQKzF/jJk6ya"
In-Reply-To: <1066858032.32228.169.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2003 at 05:27:13PM -0400, Stephen Smalley wrote:
> I've merged this patch with the ~0UL -> ~0U fix.

I just find out that this patch have unpredictable side effects. It uses
integers of different size at the same time (op and roleop uses int,
cexpr and cexpr_prim uses uintptr_t).

this should work on 32bit machines (big and little), but breaks if
uintptr_t is larger than int, because accessing the int member only
writes the corresponding 32bit. the attached sources demonstrates this
problem.

bastian

-- 
Ahead warp factor one, Mr. Sulu.

--FsscpQKzF/jJk6ya
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <stdint.h>
#include <stdio.h>

union
{
  uint16_t val1;
  uint32_t val2;
} test;

int main (void)
{
  test.val2 = 1 | 1 << 16;
  printf ("write 0x%x into 32\n", 1 | 1 << 16);
  printf ("32: 0x%x\n", test.val2);
  printf ("16: 0x%hx\n", test.val1);
  test.val1 = 1;
  printf ("write 0x%x into 16\n", 1);
  printf ("32: 0x%x\n", test.val2);
  printf ("16: 0x%hx\n", test.val1);
}

--FsscpQKzF/jJk6ya--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
