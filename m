Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA6AkgIi006194
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 05:46:42 -0500 (EST)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA6AjJgn029334
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 10:45:20 GMT
Date: Sat, 6 Nov 2004 11:46:44 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Message-ID: <20041106104644.GC9912@rom.cip.ifi.lmu.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com> <200411031641.59816.russell@coker.com.au> <4189060A.1010003@redhat.com> <1099507502.3861.11.camel@nexus.verbum.private> <1099519994.3861.18.camel@nexus.verbum.private> <41896085.3080407@redhat.com> <20041105130959.GA2593@cip.ifi.lmu.de> <1099689868.16488.36.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1099689868.16488.36.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Carter <jwcart2@epoch.ncsc.mil> [2004-11-05 22:22]:
> On Fri, 2004-11-05 at 08:10, Thomas Bleher wrote:
> > One additional request, for the NSA team:
> > Is it possible to accelerate the rate at which patches are merged?
> > Right now splitting patches is tedious work because there is such a long
> > period between the time a patch is submitted and the time it is merged
> > (sometimes up to four weeks!). If patches were merged within one week of
> > posting them (assuming there are no problems and objections), submitters
> > would be encouraged to send smaller patches more often which would make
> > review much easier.
> > I would be very grateful if something could be done about this. Right
> > now the changes I have in my local policy amount to at least ten
> > patches, but I'm very reluctant to send them because there are still
> > some patches pending and merging is work enough as it is.
> > If patch merging could be sped up and some notification sent if a patch 
> > was rejected, that would really rock!
> > 
> I am sorry I have taken a while to merge some patches.  If you think it
> is taking too long, feel free to send me an email.
>  
> I will make sure that I send some sort of notification if a patch is
> rejected.
> 
> Note to all:
> I do try to review each patch, so smaller, easier to understand, well
> explained patches are more likely to be merged faster.

Thanks for merging the patches. Let me add that your work is really
appreciated. I think it is very good that you review patches (even if it
takes some time), having someone looking over all patches makes sure
that the quality of the policy stays as high as it is.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
