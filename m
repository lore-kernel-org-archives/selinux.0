Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6K1VVm3026578
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 21:31:31 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6K1VUqY006616
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 01:31:30 GMT
Received: by iyf40 with SMTP id 40so5226706iyf.12
        for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 18:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110719224644.1622385u2ewqtf0g@webmail.tuffmail.net>
References: <20110719224644.1622385u2ewqtf0g@webmail.tuffmail.net>
Date: Tue, 19 Jul 2011 21:31:29 -0400
Message-ID: <CACLa4ps4iGtD0Ov_01V+jxsd=NuFc_C2on74Haxd-M1O35ndaQ@mail.gmail.com>
Subject: Re: What is /selinux/null?
From: Eric Paris <eparis@parisplace.org>
To: Martin Orr <martin@martinorr.name>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 19, 2011 at 5:46 PM, Martin Orr <martin@martinorr.name> wrote:
> Can anyone explain the following AVC denial?  What is the purpose of
> /selinux/null and why would ifconfig open it instead of /dev/null?
>
> type=1400 audit(1311107387.404:18): avc:  denied  { use } for  pid=2211
> comm="wpa_supplicant" path="/null" dev=selinuxfs ino=22
> scontext=system_u:system_r:NetworkManager_t:s0
> tcontext=system_u:system_r:ifconfig_t:s0 tclass=fd

That is neat!  so /selinux/null is the same thing as /dev/null.  When
a task exec's a new task and the child does not have permission to an
open fd the kernel will close the fd and open /selinux/null in it's
place.  In this case it's not the label on the actual inode that is a
problem but it is instead the label on the fd.  at some point
ifconfig_t was passed an fd it couldn't use and the kernel replaced it
with /selinux/null.  ifconfig then leaked that fd onto wpa_supplicant.

My guess is that the real bug is whatever tried to pass ifconfig an fd
which it was not allowed to use.  Then we work from there.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
