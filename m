Subject: Re: [LTP] Fwd:  [PATCH] Create $SELINUXTMPDIR in each of the tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
Cc: subrata@linux.vnet.ibm.com, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <op.us5xofaeu2flwt@debian>
References: <1240080458.5108.18.camel@subratamodak.linux.ibm.com>
	 <1241032058.18249.277.camel@localhost.localdomain>
	 <op.us5xofaeu2flwt@debian>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Apr 2009 15:40:01 -0400
Message-Id: <1241034001.18249.298.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-29 at 21:27 +0200, Jiří Paleček wrote:
> On Wed, 29 Apr 2009 21:07:38 +0200, Stephen Smalley <sds@tycho.nsa.gov>  
> wrote:
> 
> > On Sun, 2009-04-19 at 00:17 +0530, Subrata Modak wrote:
> >> Stephen,
> >>
> >> Would you like to say something about the following Patch ?
> >
> > Yes, it breaks the selinux testsuite for me.  Please revert.
> 
> How exactly does it break it?

Running it via test_selinux.sh was generating errors like:
cd: /testcases/bin: No such file or directory
in selinux.outfile, producing a couple bogus FAILs.

After backing out your setcurrent change and your SELINUXTMPDIR changes
and Chris' patch and running it via test_selinux.sh, I'm down to 6
remaining FAILs, likely due to further tightening of refpolicy since we
last updated the test policy.  I'll have to go through them one by one
and examine the exact denials and error messages.

> 
> >>
> >> -------- Forwarded Message --------
> >> From: Jiri Palecek > <<jirka@debian.POK.IBM.COM>
> >> Cc: ltp-list@lists.sourceforge.net <ltp-list@lists.sourceforge.net>
> >> Subject: [LTP] [PATCH] Create $SELINUXTMPDIR in each of the tests
> >> Date: Thu, 16 Apr 2009 12:52:05 +0200
> >>
> >> Hello,
> >>
> >> while running the selinux tests, I was contemplating the way the  
> >> $SELINUXTMPDIR is created. It seems to me that creating it in each test  
> >> individually would allow running the tests in parallel, make some hacks  
> >> needed to prevent interference of the tests unnecessary, allow the  
> >> tests to be run directly from ltpmenu et al., and wouldn't add much  
> >> more code. What do you think about this?
> >>
> >> PS: This patch still has issues, namely, the cleanup is denied  
> >> sometimes.
> >>
> >> Regards
> >>  Jiri Palecek
> >>
> >>
> >> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> >> ---
> >>  .../tests/bounds/selinux_bounds.sh                 |    7 +++----
> >>  .../tests/capable_file/selinux_capable_file.sh     |    8 +++-----
> >>  .../tests/capable_sys/selinux_capable_sys.sh       |    8 ++++----
> >>  .../tests/entrypoint/selinux_entrypoint.sh         |    7 +++----
> >>  .../execute_no_trans/selinux_execute_no_trans.sh   |    7 +++----
> >>  .../tests/fdreceive/selinux_fdreceive.sh           |    7 +++----
> >>  .../selinux-testsuite/tests/file/selinux_file.sh   |   14  
> >> ++++----------
> >>  .../tests/inherit/selinux_inherit.sh               |    8 +++-----
> >>  .../selinux-testsuite/tests/ioctl/selinux_ioctl.sh |    5 ++++-
> >>  .../selinux-testsuite/tests/link/selinux_link.sh   |    7 +++----
> >>  .../selinux-testsuite/tests/mkdir/selinux_mkdir.sh |    7 +++----
> >>  .../selinux-testsuite/tests/open/selinux_open.sh   |    7 +++----
> >>  .../tests/readlink/selinux_readlink.sh             |    7 +++----
> >>  .../tests/relabel/selinux_relabel.sh               |    7 +++----
> >>  .../tests/rename/selinux_rename.sh                 |    7 +++----
> >>  .../selinux-testsuite/tests/rxdir/selinux_rxdir.sh |    7 +++----
> >>  .../tests/setattr/selinux_setattr.sh               |    7 +++----
> >>  .../selinux-testsuite/tests/stat/selinux_stat.sh   |    7 +++----
> >>  18 files changed, 57 insertions(+), 77 deletions(-)
> >>
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
> >> index fb0876e..5a3fa06 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
> >> @@ -14,8 +14,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=4
> >>
> >> -	# Remove any leftover test directories from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/bounds_file*
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create test files
> >>  	dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file      count=1
> >> @@ -141,8 +141,7 @@ test06()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup
> >> -	rm -rf $SELINUXTMPDIR/bounds_file*
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:	main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/capable_file/selinux_capable_file.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/capable_file/selinux_capable_file.sh
> >> index 86d89a1..f5f1040 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/capable_file/selinux_capable_file.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/capable_file/selinux_capable_file.sh
> >> @@ -17,9 +17,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=10
> >>
> >> -	# Clean up from a previous run
> >> -	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> -	rm -f $SELINUXTMPDIR/temp_file2 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>  }
> >>
> >>  #
> >> @@ -233,8 +232,7 @@ test10()
> >>
> >>  cleanup()
> >>  {
> >> -	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> -	rm -f $SELINUXTMPDIR/temp_file2 2>&1
> >> +    rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/capable_sys/selinux_capable_sys.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/capable_sys/selinux_capable_sys.sh
> >> index da880b3..1965142 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/capable_sys/selinux_capable_sys.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/capable_sys/selinux_capable_sys.sh
> >> @@ -17,8 +17,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=8
> >>
> >> -        # Clean up from a previous run
> >> -        rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>  }
> >>
> >>  #
> >> @@ -195,8 +195,7 @@ test08()
> >>
> >>  cleanup()
> >>  {
> >> -	# Remove files
> >> -	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> @@ -215,6 +214,7 @@ test02 || EXIT_VAL=$RC
> >>  test03 || EXIT_VAL=$RC
> >>  test04 || EXIT_VAL=$RC
> >>  cleanup
> >> +setup
> >>  test05 || EXIT_VAL=$RC
> >>  test06 || EXIT_VAL=$RC
> >>  test07 || EXIT_VAL=$RC
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> >> index 4ae880a..bd58845 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/entrypoint/selinux_entrypoint.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=2
> >>
> >> -        # Clean up from a previous run
> >> -        rm -f $SELINUXTMPDIR/true 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>  }
> >>
> >>  test01()
> >> @@ -63,8 +63,7 @@ test02()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -f $SELINUXTMPDIR/true
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/selinux_execute_no_trans.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/selinux_execute_no_trans.sh
> >> index 2c58fe1..67bfe6f 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/selinux_execute_no_trans.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/selinux_execute_no_trans.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=2
> >>
> >> -        # Clean up from a previous run
> >> -        rm -f $SELINUXTMPDIR/true 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>  }
> >>
> >>  test01()
> >> @@ -66,8 +66,7 @@ test02()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -f $SELINUXTMPDIR/true
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/fdreceive/selinux_fdreceive.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/fdreceive/selinux_fdreceive.sh
> >> index 4ec7f2e..76bbedd 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/fdreceive/selinux_fdreceive.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/fdreceive/selinux_fdreceive.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=3
> >>
> >> -	# Remove any leftover test file from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file $SELINUXTMPDIR/test_file2  
> >> $SELINUXTMPDIR/test_sock
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create and label the test files.
> >>  	touch $SELINUXTMPDIR/test_file $SELINUXTMPDIR/test_file2
> >> @@ -100,8 +100,7 @@ cleanup()
> >>  	# Kill the server.
> >>  	kill -s TERM $PID
> >>
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file $SELINUXTMPDIR/test_file2  
> >> $SELINUXTMPDIR/test_sock
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
> >> index 0c88e9b..71b09dd 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
> >> @@ -17,10 +17,9 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=14
> >>
> >> -	# Clean up from a previous run
> >> -	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> -	rm -f $SELINUXTMPDIR/temp_file2 2>&1
> >> -	rm -f $SELINUXTMPDIR/temp_file3 2>&1
> >> +	LTPBIN=$LTPROOT/testcases/bin
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	#
> >>  	# Create the temp files
> >> @@ -361,12 +360,7 @@ test14()
> >>
> >>  cleanup()
> >>  {
> >> -	#
> >> -	# Delete the temp files
> >> -	#
> >> -	rm -f $basedir/temp_file 2>&1
> >> -	rm -f $basedir/temp_file2 2>&1
> >> -	rm -f $basedir/temp_file3 2>&1
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  #
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/inherit/selinux_inherit.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/inherit/selinux_inherit.sh
> >> index 8a48185..13defc8 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/inherit/selinux_inherit.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/inherit/selinux_inherit.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=3
> >>
> >> -	# Clean up from a previous run
> >> -	rm -f $SELINUXTMPDIR/test_file 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file with the test_inherit_file_t type
> >>  	# for use in the tests.
> >> @@ -97,9 +97,7 @@ test03()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> -	cd $SAVEPWD
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.sh
> >> index a46a8f9..61bfacd 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.sh
> >> @@ -17,6 +17,9 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=2
> >>
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >> +
> >>  	# Create a temporary file for testing
> >>  	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >>  	touch $SELINUXTMPDIR/temp_file 2>&1
> >> @@ -65,7 +68,7 @@ test02()
> >>
> >>  cleanup()
> >>  {
> >> -	rm -f $SELINUXTMPDIR/temp_file 2>&1
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/link/selinux_link.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/link/selinux_link.sh
> >> index b78a2df..b666320 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/link/selinux_link.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/link/selinux_link.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=6
> >>
> >> -	# Clean up from a previous run
> >> -	rm -f $SELINUXTMPDIR/test_dir 2>&1
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test directory with the test_addname_dir_t type
> >>  	# for use in the tests.
> >> @@ -157,8 +157,7 @@ test06()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_dir
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh
> >> index 79f1c57..a8b8eb7 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/mkdir/selinux_mkdir.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=5
> >>
> >> -	# Remove any leftover test directory from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_dir
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test directory with the test_mkdir_dir_t type
> >>  	# for use in the tests.
> >> @@ -129,8 +129,7 @@ test05()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_dir
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/open/selinux_open.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/open/selinux_open.sh
> >> index de7be4c..edd5922 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/open/selinux_open.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/open/selinux_open.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=8
> >>
> >> -	# Remove any leftover test directories from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file.
> >>  	touch $SELINUXTMPDIR/test_file
> >> @@ -180,8 +180,7 @@ test08()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/readlink/selinux_readlink.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/readlink/selinux_readlink.sh
> >> index 2c4a885..11e6c29 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/readlink/selinux_readlink.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/readlink/selinux_readlink.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=3
> >>
> >> -	# Remove any leftover test files from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file $SELINUXTMPDIR/test_symlink
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file.
> >>  	touch $SELINUXTMPDIR/test_file 2>&1
> >> @@ -86,8 +86,7 @@ test03()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file $SELINUXTMPDIR/test_symlink
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh
> >> index 8d8bad3..076228d 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=3
> >>
> >> -	# Remove any leftover test file from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file with the test_relabel_oldtype_t
> >>  	# type for use in the tests.
> >> @@ -90,8 +90,7 @@ test03()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh
> >> index 36e2485..ca9e409 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/rename/selinux_rename.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=9
> >>
> >> -	# Remove any leftover test directories from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/src_dir $SELINUXTMPDIR/dst_dir
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create the source and destination test directories for the rename.
> >>  	mkdir --context=system_u:object_r:test_rename_src_dir_t  
> >> $SELINUXTMPDIR/src_dir 2>&1
> >> @@ -231,8 +231,7 @@ test09()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/src_dir $SELINUXTMPDIR/dst_dir
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh
> >> index 82c335e..7d836ce 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/rxdir/selinux_rxdir.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>          export TST_COUNT=0
> >>  	export TST_TOTAL=4
> >>
> >> -	# Remove any leftover test directory from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_dir
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test dir with the test_rxdir_dir_t type
> >>  	# for use in the tests.
> >> @@ -102,8 +102,7 @@ test04()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_dir
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/setattr/selinux_setattr.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/setattr/selinux_setattr.sh
> >> index dd30179..2ab6070 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/setattr/selinux_setattr.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/setattr/selinux_setattr.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=4
> >>
> >> -	# Remove any leftover test file from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file with the test_setattr_file_t type
> >>  	# for use in the tests.
> >> @@ -100,8 +100,7 @@ test04()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >> diff --git  
> >> a/testcases/kernel/security/selinux-testsuite/tests/stat/selinux_stat.sh  
> >> b/testcases/kernel/security/selinux-testsuite/tests/stat/selinux_stat.sh
> >> index 98ed91f..3a13122 100755
> >> ---  
> >> a/testcases/kernel/security/selinux-testsuite/tests/stat/selinux_stat.sh
> >> +++  
> >> b/testcases/kernel/security/selinux-testsuite/tests/stat/selinux_stat.sh
> >> @@ -15,8 +15,8 @@ setup()
> >>  	export TST_COUNT=0
> >>  	export TST_TOTAL=2
> >>
> >> -	# Remove any leftover test file from prior failed runs.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	SELINUXTMPDIR=$(mktemp -d)
> >> +	chcon -t test_file_t $SELINUXTMPDIR
> >>
> >>  	# Create a test file with the test_stat_file_t type
> >>  	# for use in the tests.
> >> @@ -64,8 +64,7 @@ test02()
> >>
> >>  cleanup()
> >>  {
> >> -	# Cleanup.
> >> -	rm -rf $SELINUXTMPDIR/test_file
> >> +	rm -rf $SELINUXTMPDIR
> >>  }
> >>
> >>  # Function:     main
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Stay on top of everything new and different, both inside and
> >> around Java (TM) technology - register by April 22, and save
> >> $200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
> >> 300 plus technical and hands-on sessions. Register today.
> >> Use priority code J9JMT32. http://p.sf.net/sfu/p
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
