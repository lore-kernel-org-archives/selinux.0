Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA14421
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 14:01:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04857
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 18:58:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA04851
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 18:58:51 GMT
Date: Fri, 6 Dec 2002 14:00:35 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200212061845.56709.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0212061326220.27615-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Dec 2002, Russell Coker wrote:

>
> There apparently is.  Apparently there is functionality needed by the
> hwclock_t domain on Red Hat but not for other systems.  If this is not the
> case then the following comment is wrong.
> # hwclock needs to search file_t directories when run from rc.sysinit on RH8
>

  Yes, the comment is misleading; sorry. But it doesn't state this is
the ONLY situation the rule applies. The actual rule has nothing to do
with rpm_t domain. Easy to fix: remove the comment.

>
> If you have hwclock on a non-RedHat system then you don't need policy that is
> specific to Red Hat!
>

  But I need a policy, and it would be easier to reuse the example policy
if I don't have to untangle it from itself.

>
> I don't think that you'll need to do that often (if at all).
>

  Not too often right now, and I'd like to keep it that way :) But
initrc.te looks like it will need to have the if(rpm.te) because Slackware
has /boot as well.


-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
