Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1GFIcBv010197
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2012 10:18:38 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1FD6F208C9
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2012 10:18:37 -0500 (EST)
Subject: Re: Force avc_has_perm to return success if enforcing == 0;
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Date: Thu, 16 Feb 2012 10:18:08 -0500
In-Reply-To: <4F3AD084.5060304@redhat.com>
References: <4F3AD084.5060304@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1329405489.2867.8.camel@lenny>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-14 at 16:22 -0500, Daniel J Walsh wrote:
> I would like to patch libselinux to always return 0 on avc_has_perm if
> the machine is in permissive mode.
> 
> This will allow Userspace Object Managers to work even if the system
> is totally mislabeled and processes as running with bad context.
> Currently if a program like dbus asks with a bad process label it can
> get denials even in permissive mode.

The patch seems like it could at least use a comment.

For reference the previous discussion was here:

http://marc.info/?l=selinux&m=123973525511476&w=2

I'm not opposed to the proposed patch, but ultimately while it will
make their system not crash when in permissive, it also won't help
much in getting people towards an enforcing system.  It seems to me
we need to improve:

1) The notification that the system requires a relabel.  If terminals
   were HTML, we'd be using <blink>
2) The process of relabeling.
   I think fixfiles defaulting to "all files on all mounted filesystems"
   is kind of wrong.  We should only relabel things installed by RPM
   first, which should get you back to a clean slate for the system,
   then you can look at relabeling your custom web content, etc.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
