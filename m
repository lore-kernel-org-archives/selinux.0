Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6MHf3LG007729
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 13:41:03 -0400
Date: Wed, 22 Jul 2015 13:41:00 -0400
From: "J. Bruce Fields" <bfields@fieldses.org>
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150722174100.GJ22718@fieldses.org>
References: <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
 <87fv4owvxv.fsf@x220.int.ebiederm.org>
 <20150717000914.GO7943@dastard>
 <87380nobs4.fsf@x220.int.ebiederm.org>
 <20150717024735.GW3902@dastard>
 <20150721173721.GE11050@fieldses.org>
 <20150722075640.GE7943@dastard>
 <20150722140923.GD22718@fieldses.org> <55AFCA6A.60304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AFCA6A.60304@gmail.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Dave Chinner <david@fromorbit.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 22, 2015 at 12:52:58PM -0400, Austin S Hemmelgarn wrote:
> On 2015-07-22 10:09, J. Bruce Fields wrote:
> >On Wed, Jul 22, 2015 at 05:56:40PM +1000, Dave Chinner wrote:
> >>On Tue, Jul 21, 2015 at 01:37:21PM -0400, J. Bruce Fields wrote:
> >>>On Fri, Jul 17, 2015 at 12:47:35PM +1000, Dave Chinner wrote:
> >>>So, for example, a screwed up on-disk directory structure shouldn't
> >>>result in creating a cycle in the dcache and then deadlocking.
> >>
> >>Therein lies the problem: how do you detect such structural defects
> >>without doing a full structure validation?
> >
> >You can prevent cycles in a graph if you can prevent adding an edge
> >which would be part of a cycle.
> >
> Except if the user can write to the filesystem's backing storage (be
> it a device or a file), and has sufficient knowledge of the on-disk
> structures, they can create all the cycles they want in the
> metadata. So unless the kernel builds the graph internally by
> parsing the metadata _and_ has some way to detect that the on-disk
> metadata has hit a cycle (which may not just involve 2 items),

Understood.  Again, see the d_ancestor call in d_splice_alias, this is
exactly what it checks for.

> then
> you still have the potential for a DoS attack.

> Trust me, I've done this before (quite a while back when I was just
> starting out with programming on Linux) with hard-link cycles in an
> ext4 filesystem in a virtual machine just to see what would happen
> (IIRC, something deadlocked, I can't remember though if it was fsck
> or trying to access the file once the FS was mounted) (and in fact,
> I think I may try this again just to see if anything has changed).

I've also seen bugs caused by loops in corrupted ext4 filesystems.  As
far as I know, they're fixed as of 95ad5c291313b.

(I mentioned the example of dcache loops because it's something I
happened to run across before.  I'm sure there are any number of cases
where we need similar checking to keep internal data structures
consistent in the face of unexpected filesystem content.)

--b.
