Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VBFWrT011290
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 07:15:33 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VBFW5m018757
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 11:15:32 GMT
Date: Tue, 31 Aug 2004 12:26:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>, linux-hotplug-devel@lists.sourceforge.net,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831112644.GB11456@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040830203140.GB31497@lkcl.net> <20040831050252.GF10151@lbsd.net> <20040831094908.GA2098@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040831094908.GA2098@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 10:49:08AM +0100, Luke Kenneth Casson Leighton wrote:

> > Seeing as my initial /dev is on a persistent 
> > filesystem i don't have a problem with pre-udev stuff running.
> 
>  well.... you shouldn't... until you reinitialise or somehow delete,
>  upgrade or otherwise modify the "old" /dev [which you will find is
>  remounted --rbind to /.dev].
> 
>  try it: do setfiles /etc/selinux/src/file_contexts/file_contexts /.dev
>  and then reboot [in permissive mode!!!]
> 
>  due to the present files/types.fc, you will find that the entire
>  /.dev gets relabelled to something completely useless: root_t
>  or default_t.  i think it's default_t.
> 
>  consequently your next reboot in enforcing mode will fail because
>  /sbin/init tries to access /dev/null and /dev/initctl etc. as
>  default_t ... and it can't.
> 
>  should you choose to deal with this, replace /u?dev with /[\.u]dev or
>  some suitable regexp that i haven't a clue how to write so i just
>  did /.?u?dev and that did the trick.
 
 it's insufficient to add /.?u?dev to just file_contexts/types.fc
 you also have to search in file_contexts/program/* for /dev
 and set the right context there, too.

 there is i believe a bug at present in
 e.g. file_contexts/program/init.fc because it only covers
 /dev/initctl not /udev/initctl and not /.dev/initctl.

 i think this one is the only one that's really really critical
 [except on redhat of course where they all should be /u?dev]
 because if /.dev/initctl gets set to default_t, you're stuffed
 at next boot.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
