Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA19500
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 21:57:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB82vnI01946
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 02:57:49 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gB82vkf01942 for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 02:57:46 GMT
Date: Sun, 8 Dec 2002 14:01:34 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Wayne Salamon <wsalamon@tislabs.com>, selinux@tycho.nsa.gov
Subject: Re: new policy
Message-ID: <20021208030134.GC1747@snoopy.apana.org.au>
References: <Pine.LNX.4.33.0212060928110.27194-100000@vox.gw.tislabs.com> <200212061845.56709.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212061845.56709.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 06, 2002 at 06:45:56PM +0100, Russell Coker wrote:
> >  > What do you think of Brian's work on XML for policy?
> >
> >   I haven't looked at it.  Does it solve the issues we are dealing with
> > here, or is it just a representation of policy in an XML form?
> 
> Not sure.  Brian, would you like to comment?

My selinux policy isn't just a 1:1 mapping of the current design,
it is a completely different approach (as explained in my other
E-Mails to this list).

I haven't yet focused on this issue, but I imagine that there
are a number of ways this could be solved.

(disclaimer: I am not actually sure what the policy line in question
does, or why it is red-hat specific).

For instance, the simplest approach (and most like the current
approach) would be to have an attribute, eg. os="redhatx.y" and
that rule only takes place for that OS.

Another way might be a indirect approach, more like that used by
autoconf. eg. os="redhatx.y" has[1] "rpm,rw_boot,broken_hwclock".

Which would mean that rules could be specified only to build if
the OS is one that had, say RPM defined.

This could be done with the existing M4 stuff in fact, eg:

define(`os_redhat',`
define(`has_rpm')
define(`rw_boot')
define(`broken_hwclock')
')

define(`os_debian',`
define(`has_deb')
')

then in rpm.te:

ifdef(`rw_boot',`
give read/write access to /boot/*
')

and some automatic configure script would automatically define os_redhat
or os_debian.

Users could then override or replace these values as required.

Other OS with similar features of existing OS could easierly be
catered for.

Obviously I haven't put much though into this (the above doesn't handle
different OS versions for instance; even then you could have different
package versions), but hopefully it should give you the general idea.

Maybe something similar could be done for packages too, so
package_postfix_x.y would get called if lilo x.y was installed? So
current versions could define postfix_has_bug_xxx and
postfix_has_bug_yyy which require workarounds in policy, but as soon as
you upgrade to a fixed version these workarounds will go away? Similarly
you could do this for optional stuff, eg.
postfix_has_smtpd_filter_configured.

Just some rough ideas. These still need some work (obviously you don't
want to create thousands of package_postfix_* macros for every version
of postfix that exists, ideally package ranges would need to be
supported somehow; OR some sort of autoconf test maybe to test if these
"features" are required, if this is possible).

Comments?

Notes:

[1] I can't think of a better word then "has" right now.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
