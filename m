Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2VISE5U021427
	for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2006 13:28:14 -0500
Received: from mtaout02-winn.ispmail.ntl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2VIQTeG007011
	for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2006 18:26:29 GMT
Message-ID: <442D74B8.7060601@hotmail.com>
Date: Fri, 31 Mar 2006 19:28:08 +0100
From: James de Lurker <jtl2nospamMUNGIEjump@hotmail.com>
Reply-To: see.the.sig.2.reply.by.email.offlist@hotmail.com
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Need testers for Modules policicy on RHEL4
References: <442B182D.9060104@redhat.com>  <442B7848.8060406@hotmail.com> <1143724806.24555.121.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143724806.24555.121.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Apologies to any on the list that I may have offended with a distraction.
(readers focussed only upon RHEL rpm testing can safely skip this subthread)

On Thu, 30 Mar 2006 08:20:06 -0500  Stephen Smalley wrote:
> On Thu, 2006-03-30 at 07:18 +0100, James de Lurker wrote:
> I think you are confused.
Confusion is likely, even to many looking closely at the project.
As it was re-based upon FC Following EOL of RedHat Linux products.
FC is the community supported openly available non-profit distro.

Thank you for addressing the points seriously with quality
replies, both on-list and off, in private email. The time that you
took to do that is appreciated, and the spirit that you did it in
is commendable.


> Also, if you look at the minutes from the SELinux developer summit,
> you'll see that there are plans to improve pan-distribution support and
> create a more viable upstream SELinux development community that is not
> so closely coupled to Fedora, see:
> http://www.selinux-symposium.org/2006/summit.php

Thanks!
I will indeed do that. Skimming this list as a non-participant since the
EOL of the last mainstream enterprise distro selinux was based upon is
clearly insufficient. The experimental gentoo LiveCD selinux distros
are of some interest. Its less painful to learn or demonstrate by breaking
things in ramdisk ( or virtual machine hosted filesystems, come to that )

Should the project core return to a neutral base that also has enterprise
credibility, I'll be back, with personal contribution, testing, even if no
longer as competent at the developer / packager leading edge.

Constructive points outstanding on competition issues are OT, and I will
not pollute this list with them. (Followups later by private email).

The hard work that many here have put in since the projects inception, as
an invasive kernel patch to an already heavily vendor patched kernel, is
quite remarkable. For those that care to pause, look back, and compare.

Now, there is the world of LSM.
A summary on progress of convergence of LSM and the selinux LSM
could be valuable for readers that deal with kernel issues besides
selinux but might benefit from knowledge of the most crucial
differences. Other LSM projects that perhaps ought to be designed to
co-exist with selinux LSM come to mind here. The LSM developers list
seems a bit indefinate in this area.

-- 

  -- James

>From and Reply To are INVALID.

All public postings use munged headers[1]- To contact me off list:
  1) Remove "M U N G I E j u m p" ONLY: leave that "nospam" in there!
  2) change "hotmail" 2 "myrealbox" after the @


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
