Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UKKVrT007684
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:20:31 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UKKQ10002724
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 20:20:30 GMT
Date: Mon, 30 Aug 2004 21:31:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040830203140.GB31497@lkcl.net>
References: <20040830173744.GD10151@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040830173744.GD10151@lbsd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 07:37:44PM +0200, Nigel Kukard wrote:
> Just an idea, but why not have udev set the context on its root path?
 
 you mean on /dev, i presume?

 well i had to patch selinux/hooks.c to allow this [on a tmpfs]
 by relaxing the criteria of the "fscontext=" option for mount.

 otherwise it's not _possible_ t set the context on /dev as it is
 mounted [on a tmpfs].

 [if /dev was a persistent filesystem everything would be hunky-dory
  and this wouldn't be an issue].


 with that in mind, it's more that because you're putting device
 inodes into a non-persistent filesystem, you end up getting the
 "default" rules and so you must "restore" the contexts, or
 you must patch udev to "understand" the contents of
 /etc/selinux/src/file_contexts/file_contexts (using matchpathcon()
 and setfscreatecon() from libselinux) such that it will create
 inodes with the right file context.

 like i said, if /dev was a persistent filesystem, and if device
 inodes never disappeared, this wouldn't be a problem: you could run
 setfiles /etc/selinux/src/file_contexts/file_contexts /dev and
 be done with it...

 ... but that's not how udev works: it deletes and creates inodes
 on demand; nothing exists at boot-time, it's all created on-demand.

 so, not only must udev be patched to restore contexts but also
 the policies and various hacks added to "cope" with /dev being
 incredibly basic at startup - prior to udev running.

 _including_ dealing with getting the contexts correct on entries
 in /.dev [the old /dev remounted with mount --rbind]

 l.



-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
