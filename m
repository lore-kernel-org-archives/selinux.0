Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5LM3Ii003364
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:22:03 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5LM5F9011823
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 21:22:06 GMT
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <20041105130959.GA2593@cip.ifi.lmu.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
	 <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com>
	 <200411031641.59816.russell@coker.com.au> <4189060A.1010003@redhat.com>
	 <1099507502.3861.11.camel@nexus.verbum.private>
	 <1099519994.3861.18.camel@nexus.verbum.private>
	 <41896085.3080407@redhat.com>  <20041105130959.GA2593@cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099689868.16488.36.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 16:24:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 08:10, Thomas Bleher wrote:
> * Daniel J Walsh <dwalsh@redhat.com> [2004-11-04 16:23]:
> > Another pass at the patch.
> > 
> > Sorry about having them all together,  tried to break it apart but it 
> > would take forever.
> 
> Well, it's not _that_ bad.
> I split your patch into three pieces (attached), it was less than an
> hour of work.
> 
> * The first patch contains the nfs_home_dir cleanup and the
>   single_userdomain removal.
> 
Merged.

> * The second patch adds the daemon attribute and contains the dbus and
>   nscd related changes.
> 
Merged.

> * The third patch contains the rest.
I need to review.

> I believe the first two patches can be merged into CVS while the third
> needs more review.
> I strongly agree with Russell that we should do the can_network()
> changes the right way and not hurry anything.
> The kerberos stuff needs more changes; most people do not need kerberos,
> for them the kerberos stuff should be completely transparent.
> I hope to send a separate patch for this soon.
> 
> There are some more issues, eg:
> why does logrotate have can_exec() rights on acct_data_t? With this
> change acct_t has complete control over logrotate_t.
> I think you should annotate each change to explain why the change was
> needed.
> 
> One additional request, for the NSA team:
> Is it possible to accelerate the rate at which patches are merged?
> Right now splitting patches is tedious work because there is such a long
> period between the time a patch is submitted and the time it is merged
> (sometimes up to four weeks!). If patches were merged within one week of
> posting them (assuming there are no problems and objections), submitters
> would be encouraged to send smaller patches more often which would make
> review much easier.
> I would be very grateful if something could be done about this. Right
> now the changes I have in my local policy amount to at least ten
> patches, but I'm very reluctant to send them because there are still
> some patches pending and merging is work enough as it is.
> If patch merging could be sped up and some notification sent if a patch 
> was rejected, that would really rock!
> 
I am sorry I have taken a while to merge some patches.  If you think it
is taking too long, feel free to send me an email.
 
I will make sure that I send some sort of notification if a patch is
rejected.

Note to all:
I do try to review each patch, so smaller, easier to understand, well
explained patches are more likely to be merged faster.

> Thanks,
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
