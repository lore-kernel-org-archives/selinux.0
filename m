Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3HbDWt001374
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 12:37:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3HbCKn009484
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 17:37:12 GMT
Date: Mon, 3 Nov 2003 17:37:10 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
Message-ID: <20031103173710.GF29928@vnl.com>
References: <20031103114353.GC13273@vnl.com> <200311040115.57564.russell@coker.com.au> <20031103152731.GC29928@vnl.com> <1067876122.21113.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1067876122.21113.70.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 03, 2003 at 11:15:23AM -0500, Stephen Smalley wrote:
> On Mon, 2003-11-03 at 10:27, Dale Amon wrote:
> > Here's one that might interest Steve: load_policy can 
> > totally lock up a small memory machine if the binary 
> > policy is large.
> 
> What was the memory size and the policy size?  load_policy follows

16MB RAM on a 486DX. I've got a couple of them I use
for firewalls and testing. Poor little fellers were
about to get chucked in the skip.

I haven't got the policy size. I'll have to reset the
test system back to 'virgin' to get back to it. But 
it's easy enough to reproduce. Just take Russ's selinux-default-policy
package and answer Y to everything (I installed it and other
packages via a script the first time).

Disk makes noises for awhile, machine works away...
and then a 'top' screen I'm watching on vt2
freezes and then you can't do anything but hit the
power switch.

I 'cured' the problem by paring down the policy
to minimum size, and that loads just fine.

Note, if it is of interest, this is all being
done manually. kernel is booted with selinux=1,
but not with an initrd; I then

	mount -t selinuxfs none /selinux
	cd /etc/selinux; make install
	make load

What I'm actually working on is trying to get
an initial root file labeling working with a 
reiserfs... yeah, I finally got a round tuit. 

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
