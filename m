Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h93IIEsJ012120
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 14:18:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h93IGPZt009172
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 18:16:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h93IGOM3009169
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 18:16:24 GMT
Subject: Re: libselinux-1.2 and const usage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031003063614.GA20539@suse.de>
References: <20031003063614.GA20539@suse.de>
Content-Type: text/plain
Message-Id: <1065205090.4080.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Oct 2003 14:18:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-03 at 02:36, Thorsten Kukuk wrote:
> Hi,
> 
> when trying to add selinux support to some of my applications, I
> found out that the libselinux interface does not make usage of
> "const", which ends in a lot of compiler warnings.
> 
> Attached is a patch for libselinux to solve this.

Thanks, I've merged this into our internal CVS tree as well as the
sourceforge CVS tree.  I'd be interested in knowing what applications
you are modifying and how you are adapting them for SELinux, if you're
willing to share...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
