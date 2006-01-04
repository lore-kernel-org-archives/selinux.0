Subject: Re: Policycoreutils latest diffs.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43BAC4EA.8020106@redhat.com>
References: <43BAC4EA.8020106@redhat.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 12:36:47 -0500
Message-Id: <1136396207.27632.280.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 13:39 -0500, Daniel J Walsh wrote:
> Fixes to restorecon to handle user_only_changed even in the -vv case.
> 
> 
> Many fixes to chcat to get it working in the hundreds of different ways 
> it can be used...
> 
> Changed fixfiles to sort before doing the diff.  New way of handling 
> file_context seems to change the file_context sort order on every update 
> causing fixfiles to falsely think things have changed.  This might not 
> be ideal since ordering could cause problems.
> 
> genhomedircon fixes to make it work within anaconda.  Eliminated all 
> calls to getstatusoutput.
> 
> Added test files to be run to make sure there are no regressions on 
> updates.  Probably should get these to run automatically some how.
> 
> semanage modified to handle ports.  Currenly does not work because of 
> some of Ivan's changes to libsepol, libsemanage and libselinux have not 
> been added.

I merged the diffs to existing files as of policycoreutils 1.29.3.
However, I didn't add the new files yet, namely selisteners and the test
files.  selisteners likely needs more polishing to be generally useful.
For the test scripts, I think we need them to be in a form more amenable
to automated testing (i.e. checking the return values and/or output
themselves against expected values), and possibly they should be added
to the selinux testsuite in the ltp instead of included in
policycoreutils itself (especially since you have to install a custom
setrans.conf for your chcat tests, and semanage may be manipulating the
active policy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
