Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei
 <kaigai@kaigai.gr.jp>,
        Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <4C19CE1D.5070000@ak.jp.nec.com>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1276528366.2749.3.camel@localhost>  <4C17049D.6090106@schaufler-ca.com>
	 <1276612389.2749.38.camel@localhost>
	 <1276700025.17827.29.camel@moss-pluto.epoch.ncsc.mil>
	 <4C19CE1D.5070000@ak.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Jun 2010 10:51:21 -0400
Message-ID: <1276786281.2976.6.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-17 at 16:26 +0900, KaiGai Kohei wrote:
> (2010/06/16 23:53), Stephen Smalley wrote:
> > On Tue, 2010-06-15 at 10:33 -0400, Eric Paris wrote:
> >> On Mon, 2010-06-14 at 21:42 -0700, Casey Schaufler wrote:
> >>> Eric Paris wrote:
> >>>> On Mon, 2010-06-14 at 10:48 -0400, Stephen Smalley wrote:
> >>>>
> >>>>> On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> >>>>>
> >>>>>> There is interest in being able to see what the actual policy is that was
> >>>>>> loaded into the kernel.  The patch creates a new selinuxfs file
> >>>>>> /selinux/policy which can be read by userspace.  The actual policy that is
> >>>>>> loaded into the kernel will be written back out to userspace.
> >>>>>>
> >>>>> Why a new node vs a read op for /selinux/load?
> >>>>>
> >>>>
> >>>> No reason why I couldn't.  Just 'load' seemed to imply a connotation
> >>>> which wasn't appropriate.  If you prefer I'll switch it when I do
> >>>> another version.
> >>>>
> >>>
> >>> If it makes any difference Smack /smack/load does read as well as write.
> >>> You have the opportunity to make 2 or 3 users less confused if you do
> >>> things consistently. After all, Smack uses load because SELinux does,
> >>> the name is actually arbitrary, and why do something differently when
> >>> it doesn't really matter?
> >>
> >> I did two things yesterday.  First I switch the read
> >> from /selinux/policy to /selinux/load.  Then I undid that change and
> >> started generating the in kernel policy buffer on open() rather than on
> >> read().  It allowed me to use cat /etc/policy>  policy rather than using
> >> my own half ass hacked utility.  The reason I undid the policy->load
> >> change was because I didn't really want to store the old policy on open
> >> if they were going to write() a new policy.  I can probably make the
> >> determination based on the f_mode, but didn't really play with it yet.
> >> I  try to do both in the next go-round.
> > 
> > Unfortunately it appears that libselinux security_load_policy() does
> > open("/selinux/load", O_RDWR).  Don't ask me why.
> > 
> >> I'm still trying to figure out what I did to make malformed policies.
> >> Must have screwed something up ripping out my prink's and debug hooks,
> >> because it isn't working for me now either....
> > 
> > Assuming you've just reused the userspace policydb_write() code with
> > minor cleanups for everything except the new ebitmap format, I'd look
> > more closely there.
> > KaiGai - this is the first time where we need to convert the new kernel
> > ebitmap format back to the old one for generating a policy image from
> > the kernel policydb that can be compared to a policy file.
> > 
> I have a question. Is it necessary the following command being succeeded?
> 
>   % diff /etc/selinux/targeted/policy/policy.24 /selinux/load
> 
> Although it was a few years ago I worked for the ebitmap improvement,
> it seems to me the new ebitmap_write() correctly writes back entries
> of the given ebitmap object.
> 
> However, it is unclear for me whether this routine can correctly repair
> the original file image, or not.
> For example, if startbit of each ebitmap_node was not aligned to u64
> on the policy file, it will be fixed up on ebitmap_read(), so we lost
> an information that what was the actual startbit of ebitmap_node in the
> result.
> 
> Of course, it might be too much requirement, if we don't need the above
> diff command returns success.

They do NOT need to be the same (because I deem it so).  We already know
that range transition rules will likely be reordered in /selinux/load vs
policy.24 so minor non-meaningful differences in ebitmaps should not be
a problem.

If at some point a person has a reason to require they be the same
binary I suggest we change userspace rather than try to maintain
needless quirks in the kernel.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
