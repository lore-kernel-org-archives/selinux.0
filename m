Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h836d3La023014
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 02:39:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h836bVpQ022327
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 06:37:31 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h836bQQX022324
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 06:37:26 GMT
Date: Wed, 3 Sep 2003 16:38:53 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: James Morris <jmorris@redhat.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Enable SELinux via boot parameter
Message-ID: <20030903063853.GA8326@snoopy.apana.org.au>
References: <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com> <1062558452.1838.52.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1062558452.1838.52.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 02, 2003 at 10:07:32PM -0500, Chris PeBenito wrote:
> There is one thing I don't like about this.  SELinux should be by
> default on.  You should have to specify that its disabled, rather than
> the opposite.  In general if people are compiling their own kernels, and
> they want SELinux, they'll want it enabled by default, and shouldn't
> need to specify extra kernel parameters.  The distributions shipping one
> single kernel is more of a special case.

I don't see this as being a big problem, just that existing selinux
users will need to change lilo.conf or whatever to add the extra
parameter.

I think adding this extra parameter (whatever the default happens to be)
is a good thing, it means you can still boot even if the selinux policy
gets badly broken (eg.  due to disk curruption), or just breaks root
logins for instance.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
