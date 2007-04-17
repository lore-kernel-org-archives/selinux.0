Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HJDCUr024199
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 15:13:12 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3HJDBW2016773
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 19:13:11 GMT
Subject: Re: FCGlob
From: James Athey <jathey@tresys.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200704172007.54844.russell@coker.com.au>
References: <200704172007.54844.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 17 Apr 2007 15:07:39 -0400
Message-Id: <1176836859.8847.15.camel@exodus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-17 at 21:07 +1100, Russell Coker wrote:
> Page 3 states that a down-side is "the tree would be a binary file and not 
> human readable any more".  Why would this be so?
Perhaps this part of the paper could have been clearer.  The only reason
to leave the file_contexts in a binary format would be to save time when
parsing them into the tree for use by matchpathcon and semanage.  In
retrospect, this suggestion was premature; code first, optimize later,
right?
> Why would it be desirable to compile FCGlob to regular expressions?  Once the 
> performance benefits are proven we might as well go full-speed ahead.
It's not desirable, but it is necessary for backwards compatibility with old
toolchains.  Newer toolchains would use FCGlob directly.
> As for regex's that have no clear meaning, the only thing to do is to remove 
> them and wait for the original policy author to complain.  There are many 
> regular expressions that never matched anything and probably many more that 
> match old versions of software.
Old versions of software matter.  For example, RHEL 4 is a supported
platform for reference policy, and any file contexts that are specific
to RHEL4 need to stay in the policy, marked off with an
ifdef(`distro_rhel4' if necessary.

There also seems to be some confusion about how FCGlob contexts can be
compared and sorted.  There's a handwaving explanation of the comparison
algorithm in the presentation on FCGlob from the 2007 SELinux Symposium:
http://selinux-symposium.org/2007/slides/03-fcglob.pdf .  Look at pages
8 and 9.

James


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
