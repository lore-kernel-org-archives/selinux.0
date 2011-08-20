Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7KGtnE3013597
	for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2011 12:55:49 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7KGtm0h012337
	for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2011 16:55:48 GMT
Message-ID: <20110820175545.15612d2n6qrvs8w0@webmail.tuffmail.net>
Date: Sat, 20 Aug 2011 17:55:45 +0100
From: Martin Orr <martin@martinorr.name>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: What is /selinux/null?
References: <20110719224644.1622385u2ewqtf0g@webmail.tuffmail.net>
	<CACLa4ps4iGtD0Ov_01V+jxsd=NuFc_C2on74Haxd-M1O35ndaQ@mail.gmail.com>
In-Reply-To: <CACLa4ps4iGtD0Ov_01V+jxsd=NuFc_C2on74Haxd-M1O35ndaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed 20 Jul 02:31:29 2011, Eric Paris wrote:

> On Tue, Jul 19, 2011 at 5:46 PM, Martin Orr <martin@martinorr.name> wrote:
>> Can anyone explain the following AVC denial?  What is the purpose of
>> /selinux/null and why would ifconfig open it instead of /dev/null?
>>
>> type=1400 audit(1311107387.404:18): avc:  denied  { use } for  pid=2211
>> comm="wpa_supplicant" path="/null" dev=selinuxfs ino=22
>> scontext=system_u:system_r:NetworkManager_t:s0
>> tcontext=system_u:system_r:ifconfig_t:s0 tclass=fd
>
> That is neat!  so /selinux/null is the same thing as /dev/null.  When
> a task exec's a new task and the child does not have permission to an
> open fd the kernel will close the fd and open /selinux/null in it's
> place.  In this case it's not the label on the actual inode that is a
> problem but it is instead the label on the fd.  at some point
> ifconfig_t was passed an fd it couldn't use and the kernel replaced it
> with /selinux/null.  ifconfig then leaked that fd onto wpa_supplicant.

I decided to track this down, and it is a little more complex than that:
When the kernel reopens an fd as /selinux/null, this happens before  
the context change, so the fd gets the label of the old task.

So in this instance, the fd was leaked from ifconfig to a script  
running as wpa_cli_t.  The fd turned out to be /dev/console, coming  
from init;  wpa_cli_t has init_use_fds but only  
term_dontaudit_use_console, so the fd was silently changed to  
/selinux/null at this point.

(As Dan pointed out, the transitions ifconfig_t -> wpa_cli_t ->  
NetworkManager_t are not in refpolicy but they are in my policy.)

Best wishes,
Martin



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
