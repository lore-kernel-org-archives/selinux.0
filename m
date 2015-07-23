Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6NDJXTE031781
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 09:19:33 -0400
Date: Thu, 23 Jul 2015 09:19:28 -0400
From: "J. Bruce Fields" <bfields@fieldses.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150723131928.GA11582@fieldses.org>
References: <87fv4owvxv.fsf@x220.int.ebiederm.org>
 <20150717000914.GO7943@dastard>
 <87380nobs4.fsf@x220.int.ebiederm.org>
 <20150717024735.GW3902@dastard>
 <20150721173721.GE11050@fieldses.org>
 <20150722075640.GE7943@dastard>
 <20150722140923.GD22718@fieldses.org> <55AFCA6A.60304@gmail.com>
 <20150722174100.GJ22718@fieldses.org>
 <20150723015135.GH7943@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150723015135.GH7943@dastard>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 23, 2015 at 11:51:35AM +1000, Dave Chinner wrote:
> On Wed, Jul 22, 2015 at 01:41:00PM -0400, J. Bruce Fields wrote:
> > On Wed, Jul 22, 2015 at 12:52:58PM -0400, Austin S Hemmelgarn wrote:
> > > On 2015-07-22 10:09, J. Bruce Fields wrote:
> > > >On Wed, Jul 22, 2015 at 05:56:40PM +1000, Dave Chinner wrote:
> > > >>On Tue, Jul 21, 2015 at 01:37:21PM -0400, J. Bruce Fields wrote:
> > > >>>On Fri, Jul 17, 2015 at 12:47:35PM +1000, Dave Chinner wrote:
> > > >>>So, for example, a screwed up on-disk directory structure shouldn't
> > > >>>result in creating a cycle in the dcache and then deadlocking.
> > > >>
> > > >>Therein lies the problem: how do you detect such structural defects
> > > >>without doing a full structure validation?
> > > >
> > > >You can prevent cycles in a graph if you can prevent adding an edge
> > > >which would be part of a cycle.
> > > >
> > > Except if the user can write to the filesystem's backing storage (be
> > > it a device or a file), and has sufficient knowledge of the on-disk
> > > structures, they can create all the cycles they want in the
> > > metadata. So unless the kernel builds the graph internally by
> > > parsing the metadata _and_ has some way to detect that the on-disk
> > > metadata has hit a cycle (which may not just involve 2 items),
> > 
> > Understood.  Again, see the d_ancestor call in d_splice_alias, this is
> > exactly what it checks for.
> 
> But that only addresses one type of loop in one specific metadata
> structure.

Yep, agreed!

> There's plenty of other ways you could construct metadata
> loops that are essentially undetected and result in either deadlock
> or livelock within the filesystem code itself. e.g. just make btree
> sibling pointers loop over a range of entries that have the same
> index key (e.g. free space extents of the same size). If allocation
> then falls into this loop, the kernel will just spin searching the
> same blocks for something it will never find.  Such resource
> consumption attacks are trivial to construct but extremely difficult
> to detect because they exploit normal behaviour of the structure and
> algorithms by mangling trusted pointers.

Interesting example, thanks!  I doubt this particular example would be
*that* hard to detect?  But understood that there may be lots of others.

--b.

> 
> Of course, this sort of attack will eventually deadlock the
> filesystem because it will backs up on locks held by the live locked
> search. Once the filesystem is deadlocked, it can then cause sync()
> calls to get stuck on the filesystem. And because sync() is a global
> operation, a deadlocked filesystem in one container could cause sync
> to hang in completely unrelated container....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
