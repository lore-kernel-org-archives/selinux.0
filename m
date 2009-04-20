Date: Sun, 19 Apr 2009 20:23:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Jiri Palecek <jpalecek@web.de>,
        SE Linux <selinux@tycho.nsa.gov>, ltp-list <ltp-list@lists.sf.net>
Subject: Re: [LTP] Fwd: [PATCH] Fix an errorneous using of a different
	return value in selinux_entrypoint test
Message-ID: <20090420012348.GA20228@us.ibm.com>
References: <1240080684.5108.21.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240080684.5108.21.camel@subratamodak.linux.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> Stephen ??

Heh, this isn't an selinux issue, just trivially correct.

Acked-by: Serge Hallyn <serue@us.ibm.com>

-serge

> -------- Forwarded Message --------
> From: Jiri Palecek > <<jirka@debian.POK.IBM.COM>
> Cc: ltp-list@lists.sourceforge.net <ltp-list@lists.sourceforge.net>
> Subject: [LTP] [PATCH] Fix an errorneous using of a different return
> value in selinux_entrypoint test
> Date: Thu, 16 Apr 2009 17:59:00 +0200
> 
> Hello,
> 
> I have been trying to run the selinux tests on Debian and discovered a small flaw. The test was using a return value variable which wasn't set by the test.
> 
> I've coma across another strange (at least to me) fact - when you execute a program without path, it is searched for in $PATH. However, if the program is in one directory if $PATH and selinux rejects to run the file, the following directories in $PATH are search, and the call can succeed. Is this behavior planned? I know it can't tamper the security of selinux, but it can lead to surprising results.
> 
> Also, I've found some uses of macros not present in Debian's refpolicy. Should I send a patch for them?
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
>  .../tests/entrypoint/selinux_entrypoint.sh         |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> index bd58845..4680491 100755
> --- a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> +++ b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> @@ -52,6 +52,7 @@ test02()
> 
>  	# Verify that test_entrypoint_t can be entered via this program.
>  	runcon -t test_entrypoint_t $SELINUXTMPDIR/true
> +	RC=$?
>          if [ $RC -ne 0 ]
>          then
>  		echo "$TCID   FAIL : entrypoint failed."
> 
> 
> ------------------------------------------------------------------------------
> Stay on top of everything new and different, both inside and 
> around Java (TM) technology - register by April 22, and save
> $200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
> 300 plus technical and hands-on sessions. Register today. 
> Use priority code J9JMT32. http://p.sf.net/sfu/p
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
