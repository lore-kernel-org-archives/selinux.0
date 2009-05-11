Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>,
        ltp-list <ltp-list@lists.sf.net>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1241095530.27331.8.camel@localhost.localdomain>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
	 <1241032058.18249.277.camel@localhost.localdomain>
	 <op.us5xofaeu2flwt@debian>
	 <1241034001.18249.298.camel@localhost.localdomain>
	 <op.us51ezmiu2flwt@debian> <1241095530.27331.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Mon, 11 May 2009 12:14:07 +0530
Message-Id: <1242024247.6102.75.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-30 at 08:45 -0400, Stephen Smalley wrote:
> On Wed, 2009-04-29 at 22:48 +0200, Jiří Paleček wrote:
> > On Wed, 29 Apr 2009 21:40:01 +0200, Stephen Smalley <sds@tycho.nsa.gov>  
> > wrote:
> > 
> > > On Wed, 2009-04-29 at 21:27 +0200, Jiří Paleček wrote:
> > >> On Wed, 29 Apr 2009 21:07:38 +0200, Stephen Smalley <sds@tycho.nsa.gov>
> > >> wrote:
> > >>
> > >> > On Sun, 2009-04-19 at 00:17 +0530, Subrata Modak wrote:
> > >> >> Stephen,
> > >> >>
> > >> >> Would you like to say something about the following Patch ?
> > >> >
> > >> > Yes, it breaks the selinux testsuite for me.  Please revert.
> > >>
> > >> How exactly does it break it?
> > >
> > > Running it via test_selinux.sh was generating errors like:
> > > cd: /testcases/bin: No such file or directory
> > > in selinux.outfile, producing a couple bogus FAILs.
> > 
> > This is probably caused by the line setting LTPBIN (which shouldn't have  
> > been there in the first place, my fault), does the attached patch fix it  
> > for you?
> 
> Your patch doesn't apply - looks like it is relative to further local
> changes you have made in your own git repo (extra args to mktemp).  But
> applying the corresponding change here does fix that problem for me,
> yes.  Diff below is relative to ltp cvs.
> 
> Fix LTPBIN definition in selinux_file.sh
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Thanks.

Regards--
Subrata

> 
> ---
> 
>  testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh,v
> retrieving revision 1.5
> diff -u -r1.5 selinux_file.sh
> --- testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	21 Apr 2009 09:39:58 -0000	1.5
> +++ testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	30 Apr 2009 12:50:35 -0000
> @@ -17,7 +17,7 @@
>  	export TST_COUNT=0
>  	export TST_TOTAL=14
> 
> -	LTPBIN=$LTPROOT/testcases/bin
> +	LTPBIN=${LTPBIN:-$LTPROOT/testcases/bin}
>  	SELINUXTMPDIR=$(mktemp -d)
>  	chcon -t test_file_t $SELINUXTMPDIR
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
