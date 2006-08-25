Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PF351Q023973
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 11:03:06 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PF2lNs020762
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 15:02:47 GMT
Received: by wr-out-0506.google.com with SMTP id i11so262323wra
        for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 08:03:02 -0700 (PDT)
Message-ID: <44EF1117.7090503@kaigai.gr.jp>
Date: Sat, 26 Aug 2006 00:02:47 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: lorenzo@tuxedo-es.org
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] add fs_use_xattr on jffs2
References: <44EEE4DD.5080301@kaigai.gr.jp> <59ad41340608250656u613fd90ds5b409e33a6d8565d@mail.gmail.com>
In-Reply-To: <59ad41340608250656u613fd90ds5b409e33a6d8565d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Lorenzo.

> We talked during the symposium though we didn't have much time for it.
> Glad to see you're still working on embedded SELinux stuff. So, what's
> the current status of jffs2? It has full support for xattr now, right?

Yes, all of functions we need to enable SELinux are available.
In addition, you can enable POSIX ACL support on jffs2.
# But, POSIX ACL consumes memory as much as Ext2/3, I think it's not
# suitable for embedded. So, it should be fixed on 2.6.19. orz

> Do the Infradead guys (jffs maintainers) know about this? Or it's
> already merged in upstream?

This achievement would not have been possible without collaborating
with David Woodhouse and any other MTD peopel.
The serious of patches are already merged into Linus's git-tree via
MTD-tree and queued for 2.6.18 now.
See,
http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.18-rc1

> Are you using a special policy?  Busybox modified?

No, I installed a non-modified Nakamura's policy the small PDA,
because I didn't have enough time for this.
And, busybox is not modified by same reason.

'ps' is an exception. As it didn't work correctly, I installed
a part of the procps package.

> I think this could be a nice thing for the next symposium, say,
Please recomend it to my boss. :)

> prepare modified uClinux buildroot system, make it available so people
> can build embedded systems with native support for SELinux. Actually
> this will bring some real buzz to the field. There are many platforms
> out there supposed to be suitable for building "secure firewall
> appliances", yet none implements a single serious solution to make it
> "secure" beyond just the buzz wording itself.

What kind of modifications for uClibc is necessary, do you think?
Because I don't have enough experimence on embedded region,
any ideaes and collaborations are wellcome!

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
