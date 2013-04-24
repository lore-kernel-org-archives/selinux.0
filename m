Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3OFcSOU014977
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 11:38:44 -0400
Received: by mail-qa0-f44.google.com with SMTP id j8so974195qah.3
        for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 08:38:26 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        selinux@tycho.nsa.gov
Subject: Re: Build regressions/improvements in v3.9-rc8
Date: Wed, 24 Apr 2013 11:38:23 -0400
Message-ID: <11026580.BGB2mffbp5@sifl>
In-Reply-To: <alpine.DEB.2.00.1304232131300.11127@ayla.of.borg>
References: <alpine.DEB.2.00.1304232131300.11127@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 23, 2013 09:32:02 PM Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v3.9-rc8[1] compared to v3.8[2].
> 
> Summarized:
>   - build errors: +19/-58
>   - build warnings: +223/-377
> 
> JFYI, when comparing v3.9-rc8 to v3.9-rc7[3], the summaries are:
>   - build errors: +9/-8
>   - build warnings: +96/-145
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> As I haven't mastered kup yet, there's no verbose summary at
> http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v3.9-rc8.summa
> ry.gz
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/head/6122/ (all 118 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/5896/ (117 out of 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6094/ (all 118 configs)

...

> => 93:1 + security/selinux/netnode.c: warning: 'idx' may be used
> uninitialized in this function [-Wuninitialized]: 174:27 => 174:2, 174:27 +

FYI: A fix for this was (re)sent to the SELinux list on April 4th.

 * http://marc.info/?l=selinux&m=136508710131898&w=2

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
