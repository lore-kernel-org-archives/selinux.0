Subject: Re: [PATCH] Fix MLS handling in selinux tests
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>,
        =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>,
        "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <1241104844.27331.64.camel@localhost.localdomain>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
	 <1241032058.18249.277.camel@localhost.localdomain>
	 <op.us5xofaeu2flwt@debian>
	 <1241034001.18249.298.camel@localhost.localdomain>
	 <op.us51ezmiu2flwt@debian>
	 <1241104844.27331.64.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 May 2009 12:14:33 +0530
Message-Id: <1242024273.6102.77.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-30 at 11:20 -0400, Stephen Smalley wrote:
> Some of the selinux tests were using full security contexts but predated
> MCS/MLS and thus lacked a MLS field.  This broke testing if MLS was
> enabled in the policy but mcstransd was not running.  Change some of the
> tests to avoid the need to use full contexts at all, and others to
> conditionally append a MLS suffix if MLS is enabled.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Thanks. Merged.

Regards--
Subrata

> 
>  testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh       |    2 -
>  testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh     |   16 ++++++++--
>  testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh |    2 -
>  testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh   |    9 +++--
>  testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh     |    3 +
>  5 files changed, 24 insertions(+), 8 deletions(-)
> 
> Index: testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh,v
> retrieving revision 1.5
> diff -u -r1.5 selinux_file.sh
> --- testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	21 Apr 2009 09:39:58 -0000	1.5
> +++ testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	30 Apr 2009 15:18:04 -0000
> @@ -53,7 +53,7 @@
>  	#
>  	# Get the SID of the good file.
>  	#
> -	good_file_sid="system_u:object_r:fileop_file_t"
> +	good_file_sid=`ls -Z $SELINUXTMPDIR/temp_file | awk '{print $4}'`
>  }
> 
>  test01()
> Index: testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh,v
> retrieving revision 1.4
> diff -u -r1.4 selinux_mkdir.sh
> --- testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh	21 Apr 2009 09:39:59 -0000	1.4
> +++ testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh	30 Apr 2009 15:18:04 -0000
> @@ -89,12 +89,18 @@
>  	TCID="test04"
>  	TST_COUNT=4
>  	RC=0
> +	SUFFIX=""
> +	MLS=x`cat /selinux/mls`
> +	if [ "$MLS" == "x1" ]
> +	then
> +	    SUFFIX=":s0"
> +	fi
> 
>  	# Verify that test_create_t can create a subdirectory
>  	# with a different type.
>  	# This requires add_name to test_mkdir_dir_t and create
>  	# to test_create_dir_t.
> -	runcon -t test_create_t -- mkdir --context=system_u:object_r:test_create_dir_t $SELINUXTMPDIR/test_dir/test3 2>&1
> +	runcon -t test_create_t -- mkdir --context=system_u:object_r:test_create_dir_t$SUFFIX $SELINUXTMPDIR/test_dir/test3 2>&1
>  	RC=$?
>  	if [ $RC -eq 0 ]
>  	then
> @@ -110,11 +116,17 @@
>  	TCID="test05"
>  	TST_COUNT=5
>  	RC=0
> +	SUFFIX=""
> +	MLS=x`cat /selinux/mls`
> +	if [ "$MLS" == "x1" ]
> +	then
> +	    SUFFIX=":s0"
> +	fi
> 
>  	# Verify that test_nocreate_t cannot create 
>  	# a subdirectory with a different type.
>  	# Should fail on create check to the new type.
> -	runcon -t test_nocreate_t -- mkdir --context=system_u:object_r:test_create_dir_t $SELINUXTMPDIR/test_dir/test4 2>&1
> +	runcon -t test_nocreate_t -- mkdir --context=system_u:object_r:test_create_dir_t$SUFFIX $SELINUXTMPDIR/test_dir/test4 2>&1
>  	RC=$?
>  	if [ $RC -ne 0 ]
>  	then
> Index: testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh,v
> retrieving revision 1.4
> diff -u -r1.4 selinux_relabel.sh
> --- testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh	21 Apr 2009 09:39:59 -0000	1.4
> +++ testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh	30 Apr 2009 15:18:04 -0000
> @@ -31,7 +31,7 @@
>  	RC=0
> 
>  	# Verify that test_relabel_t can relabel the file.
> -	runcon -t test_relabel_t chcon system_u:object_r:test_relabel_newtype_t $SELINUXTMPDIR/test_file 2>&1
> +	runcon -t test_relabel_t chcon -t test_relabel_newtype_t $SELINUXTMPDIR/test_file 2>&1
>          RC=$?
>          if [ $RC -eq 0 ]
>          then
> Index: testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh,v
> retrieving revision 1.4
> diff -u -r1.4 selinux_rename.sh
> --- testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh	21 Apr 2009 09:39:59 -0000	1.4
> +++ testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh	30 Apr 2009 15:18:04 -0000
> @@ -19,15 +19,18 @@
>  	chcon -t test_file_t $SELINUXTMPDIR
> 
>  	# Create the source and destination test directories for the rename.
> -	mkdir --context=system_u:object_r:test_rename_src_dir_t $SELINUXTMPDIR/src_dir 2>&1
> -	mkdir --context=system_u:object_r:test_rename_dst_dir_t $SELINUXTMPDIR/dst_dir 2>&1
> +	mkdir $SELINUXTMPDIR/src_dir
> +	chcon -t test_rename_src_dir_t $SELINUXTMPDIR/src_dir
> +	mkdir $SELINUXTMPDIR/dst_dir
> +	chcon -t test_rename_dst_dir_t $SELINUXTMPDIR/dst_dir
> 
>  	# Create a test file to try renaming.
>  	touch $SELINUXTMPDIR/src_dir/test_file
>  	chcon -t test_rename_file_t $SELINUXTMPDIR/src_dir/test_file
> 
>  	# Create a test directory to try renaming.
> -	mkdir --context=system_u:object_r:test_rename_dir_t $SELINUXTMPDIR/src_dir/test_dir
> +	mkdir $SELINUXTMPDIR/src_dir/test_dir
> +	chcon -t test_rename_dir_t $SELINUXTMPDIR/src_dir/test_dir
> 
>  }
> 
> Index: testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh,v
> retrieving revision 1.4
> diff -u -r1.4 selinux_rxdir.sh
> --- testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh	21 Apr 2009 09:39:59 -0000	1.4
> +++ testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh	30 Apr 2009 15:18:04 -0000
> @@ -20,7 +20,8 @@
> 
>  	# Create a test dir with the test_rxdir_dir_t type
>  	# for use in the tests.
> -	mkdir --context=system_u:object_r:test_rxdir_dir_t $SELINUXTMPDIR/test_dir
> +	mkdir $SELINUXTMPDIR/test_dir
> +	chcon -t test_rxdir_dir_t $SELINUXTMPDIR/test_dir
> 
>  	# Touch a file in the directory.
>  	touch $SELINUXTMPDIR/test_dir/test_file
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
