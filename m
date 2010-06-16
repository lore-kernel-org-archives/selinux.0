Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Casey Schaufler
 <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <1276700025.17827.29.camel@moss-pluto.epoch.ncsc.mil>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1276528366.2749.3.camel@localhost>  <4C17049D.6090106@schaufler-ca.com>
	 <1276612389.2749.38.camel@localhost>
	 <1276700025.17827.29.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 11:26:17 -0400
Message-ID: <1276701977.2749.51.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-16 at 10:53 -0400, Stephen Smalley wrote:
> On Tue, 2010-06-15 at 10:33 -0400, Eric Paris wrote:

> > I did two things yesterday.  First I switch the read
> > from /selinux/policy to /selinux/load.  Then I undid that change and
> > started generating the in kernel policy buffer on open() rather than on
> > read().  It allowed me to use cat /etc/policy > policy rather than using
> > my own half ass hacked utility.  The reason I undid the policy->load
> > change was because I didn't really want to store the old policy on open
> > if they were going to write() a new policy.  I can probably make the
> > determination based on the f_mode, but didn't really play with it yet.
> > I  try to do both in the next go-round.
> 
> Unfortunately it appears that libselinux security_load_policy() does
> open("/selinux/load", O_RDWR).  Don't ask me why.

I could still generate the policy on open() if it was opened O_RDONLY.
If it was opened O_RDWR read() I 'could' make read() work if the buf was
large enough in a single shot.  Is that quirk worth the trouble of not
creating a new node in /selinux?

> > I'm still trying to figure out what I did to make malformed policies.
> > Must have screwed something up ripping out my prink's and debug hooks,
> > because it isn't working for me now either....
> 
> Assuming you've just reused the userspace policydb_write() code with
> minor cleanups for everything except the new ebitmap format, I'd look
> more closely there. 
> KaiGai - this is the first time where we need to convert the new kernel
> ebitmap format back to the old one for generating a policy image from
> the kernel policydb that can be compared to a policy file.

No question wrapping my head around the new ebitmap format was the tough
part.  I added printk's to display every ebitmap and node as it was read
in and as I wrote them out.  Got the same thing for the couple thousand
lines I could show in dmesg, so I think I'm ok there.

I was trying to use gdb yesterday to figure out what was wrong, but
could get the darn thing to break where I wanted it to.  I'll debug like
I'm used to (in the kernel) and see what I did....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
