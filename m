Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8337cLa021687
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 23:07:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h83366pQ007760
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 03:06:06 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h83365QX007757
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 03:06:06 GMT
Subject: Re: Enable SELinux via boot parameter
From: Chris PeBenito <pebenito@gentoo.org>
To: James Morris <jmorris@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
References: 
	 <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1062558452.1838.52.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Tue, 02 Sep 2003 22:07:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is one thing I don't like about this.  SELinux should be by
default on.  You should have to specify that its disabled, rather than
the opposite.  In general if people are compiling their own kernels, and
they want SELinux, they'll want it enabled by default, and shouldn't
need to specify extra kernel parameters.  The distributions shipping one
single kernel is more of a special case.

I think this is one that should be left up to distributions to patch in
themselves.

On Tue, 2003-09-02 at 18:46, James Morris wrote:
> This patch against 2.6.0-test4 adds an 'selinux' boot parameter which must 
> be used to actually enable SELinux.  It has been sent to Andrew Morton and 

> Without specifying selinux=1 as a boot parameter, SELinux will not
> register with LSM and selinuxfs will not be registered as a filesystem.  

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
