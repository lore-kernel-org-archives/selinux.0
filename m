Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16BfJRb021965
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 06:41:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16BdrQk017565
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 11:39:53 GMT
Received: from butternut.transitive.com (dsl-217-207-128-218.uk.easynet.net [217.207.128.218] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id i16BdqYo017562
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 11:39:53 GMT
Message-ID: <40237D40.500@treblig.org>
Date: Fri, 06 Feb 2004 11:40:48 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
MIME-Version: 1.0
To: Brian May <bam@snoopy.apana.org.au>
CC: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
References: <401FF280.8070301@treblig.org>	<84d68vlr6a.fsf@snoopy.apana.org.au> <402261FE.5060708@treblig.org> <84u125gpp7.fsf@snoopy.apana.org.au>
In-Reply-To: <84u125gpp7.fsf@snoopy.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian May wrote:
>>>>>>"Dave" == Dave Gilbert (Home) <gilbertd@treblig.org> writes:

> You will need to use the "main" section as well as the "selinux"
> section.  The "selinux" section is obsolete, as maintaining two
> sections become difficult under certain circumstances.
> 
> dpkg must be the only package I haven't yet moved...

Thank you! It now works.

The only remaining gotcha was that the old HOWTO that I had made a big 
point of warning you that the first thing you had to install was the 
'login' package - which now doesn't have an selinux version.

So - to summarise (for those reading this in the future - is the archive 
working?); to get SELinux working on Debian/woody:

   * Get the kernel patches (lsm and exec-shield) off Russell Coker's site
   * Get the standard debian 2.4.24 kernel package (from the main debian 
pool) and the debian kernel-patch-acl package
   * To the standard kernel apply the kernel-patch-acl patches (if you 
are doing it by hand that has to be in the order ea, acl, nfsacl)
   * Apply the exec-shield patch
   * apply the lsm patch

Add:


deb http://www.microcomaustralia.com.au/debian unstable selinux main

to your sources.list

and follow the instructions from the *new* selinux howto - that will be 
the one that tells you to mount /selinux and doesn't mention the 'login' 
package.

Note: When installing the packages it is best to do one big apt-get line 
rather than one at a time - doing them individually has a nasty habit of 
removing other packages.

Thanks,

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
