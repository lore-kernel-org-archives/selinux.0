Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83COTLa024609
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 08:24:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h83CORet011838
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:24:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h83COQlq011835 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:24:27 GMT
Subject: Re: Enable SELinux via boot parameter
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: James Morris <jmorris@redhat.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1062558452.1838.52.camel@chris.pebenito.net>
References: 
	 <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
	 <1062558452.1838.52.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1062591859.18568.313.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Sep 2003 08:24:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 23:07, Chris PeBenito wrote:
> There is one thing I don't like about this.  SELinux should be by
> default on.  You should have to specify that its disabled, rather than
> the opposite.  In general if people are compiling their own kernels, and
> they want SELinux, they'll want it enabled by default, and shouldn't
> need to specify extra kernel parameters.  The distributions shipping one
> single kernel is more of a special case.
> 
> I think this is one that should be left up to distributions to patch in
> themselves.

We considered this option, but decided it would be preferable to provide
a consistent behavior for upstream and distributions to avoid user
confusion when moving between upstream kernels and distribution kernels.
It isn't that different from having to specify "enforcing=1" to enable
enforcing mode when development support is enabled.  It is true that you
can disable development support, but how many people actually do so?
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
