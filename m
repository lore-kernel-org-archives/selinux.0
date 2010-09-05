Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o85IN2Dm008225
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2010 14:23:02 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o85IN1Q4027943
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2010 18:23:02 GMT
Received: by vws15 with SMTP id 15so3120522vws.12
        for <selinux@tycho.nsa.gov>; Sun, 05 Sep 2010 11:23:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201009052230.20602.russell@coker.com.au>
References: <201009052230.20602.russell@coker.com.au>
Date: Sun, 5 Sep 2010 14:23:00 -0400
Message-ID: <AANLkTi=Y_0B627LEnjiRvYB5DUTEoQT7OOhoR8w9-dkc@mail.gmail.com>
Subject: Re: /dev/xen/evtchn labelling in Debian and auditing
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 5, 2010 at 8:30 AM, Russell Coker <russell@coker.com.au> wrote:
> I've got a problem in Debian/Squeeze that /dev/xen/evtchn isn't being labeled.
> Running restorecon on /dev after boot gives it the right label, but by that
> time the Xen daemons have already got themselves in a state where not much
> less than a reboot will get them going again.  So I decided to use the audit
> system to tell me what process creates the device node.

Are you using devtmpfs for /dev?  If so it's probably

http://marc.info/?l=selinux&m=128295028600638&w=2

The solution is to update udev or use tmpfs instead of devtmpfs for /dev.

Separately, the fact that the device node file creation done by the
kernel is not audited stumped me for a while too.  I couldn't figure
out how things were appearing in /dev.  It's hard for me to decide how
(or if) it should be audit'd since there is no task responsible to one
should attribute the audit message.  The kernel is responsible....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
