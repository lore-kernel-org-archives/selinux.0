Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
Cc: subrata@linux.vnet.ibm.com, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1241034001.18249.298.camel@localhost.localdomain>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
	 <1241032058.18249.277.camel@localhost.localdomain>
	 <op.us5xofaeu2flwt@debian>
	 <1241034001.18249.298.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Apr 2009 15:52:30 -0400
Message-Id: <1241034750.18249.301.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-29 at 15:40 -0400, Stephen Smalley wrote:
> On Wed, 2009-04-29 at 21:27 +0200, Jiří Paleček wrote:
> > On Wed, 29 Apr 2009 21:07:38 +0200, Stephen Smalley <sds@tycho.nsa.gov>  
> > wrote:
> > 
> > > On Sun, 2009-04-19 at 00:17 +0530, Subrata Modak wrote:
> > >> Stephen,
> > >>
> > >> Would you like to say something about the following Patch ?
> > >
> > > Yes, it breaks the selinux testsuite for me.  Please revert.
> > 
> > How exactly does it break it?
> 
> Running it via test_selinux.sh was generating errors like:
> cd: /testcases/bin: No such file or directory
> in selinux.outfile, producing a couple bogus FAILs.
> 
> After backing out your setcurrent change and your SELINUXTMPDIR changes
> and Chris' patch and running it via test_selinux.sh, I'm down to 6
> remaining FAILs, likely due to further tightening of refpolicy since we
> last updated the test policy.  I'll have to go through them one by one
> and examine the exact denials and error messages.

Ah, 5 of the 6 were just due to not running mcstransd.  Need to
eliminate that as a dependency.

Last FAIL is ioctl, and that one is expected - kernel ioctl checking
changed and no one rewrote the test yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
