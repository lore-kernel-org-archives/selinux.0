Date: Tue, 25 Sep 2001 08:21:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
cc: SELinuxML <SELinux@tycho.nsa.gov>
Subject: Re: I can ' t use named on LSM-based Prototype. Why?
In-Reply-To: <002401c14595$5d1a8fb0$68026c85@ilios104>
Message-ID: <Pine.SOL.3.95.1010925081359.18877A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 25 Sep 2001, Yuichi Nakamura wrote:

> I found that named(bind 9.1.0) didn't work on SELinux(LSM-based Prototype)
> even if the kernel was flask development mode.
> 
> Why named doesn't work on LSM based prototype?

Did you apply the patch that I posted to the mailing list for
selinux_ip_postroute (See
http://marc.theaimsgroup.com/?l=selinux&m=99962056431023&w=2).
If not, then apply this patch and try again.  If you already
applied this patch, then check /var/log/messages and/or the output of
'dmesg' for any messages, particularly ones from selinux_ip_postroute.

Also, be aware that an updated release should be available soon
based on 2.4.10 with a number of bug fixes and improvements to
both LSM and SELinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
