Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76AFcrT011106
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 06:15:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76AF2ps021170
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:15:03 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Andreas Schuldei <andreas@schuldei.org>
Subject: Re: problems with selinux-policy-default 1:1.14-2
Date: Fri, 6 Aug 2004 20:15:33 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20040803233114.GQ1828@markus.schuldei.org>
In-Reply-To: <20040803233114.GQ1828@markus.schuldei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408062015.33606.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Aug 2004 09:31, Andreas Schuldei <andreas@schuldei.org> wrote:
> lrwxrwxrwx    1 root     root           33 Aug  4 00:57 src ->
> /usr/share/selinux/policy/current petrus:~# l /usr/share/selinux/policy
> total 12
> drwxr-xr-x    3 root     root         4096 Aug  4 00:57 .
> drwxr-xr-x    3 root     root         4096 Aug  4 00:57 ..
> drwxr-xr-x    9 root     root         4096 Aug  4 00:57 default
> ==========================
>
> src is a dangeling symlink.

What happened to the current directory?

> changing it to point to /usr/share/selinux/policy/default

Don't do that.  If you do that the upgrading the policy will automatically 
over-write changes that you have made to your policy.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
