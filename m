Subject: Re: Boolean utilities segv's
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200409172007.i8HK7W3w005709@turing-police.cc.vt.edu>
References: <20040917193839.GA3020@us.ibm.com>
	 <1095450979.17932.317.camel@moss-spartans.epoch.ncsc.mil>
	 <200409172007.i8HK7W3w005709@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1095453700.17932.346.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 16:41:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-17 at 16:07, Valdis.Kletnieks@vt.edu wrote:
> Probably should put in code like this:
> 
> 	fprintf(stderr,"%0: running on non-SELinux system, aborting", argv[0]);
> 	exit(1);

Ok, changes committed to the sourceforge CVS.  Added
is_selinux_enabled() tests to the boolean utilities, fail immediately if
not enabled, and added assertions to the boolean functions on
selinux_mnt.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
