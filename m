Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <4C17049D.6090106@schaufler-ca.com>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1276528366.2749.3.camel@localhost>  <4C17049D.6090106@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Jun 2010 10:33:09 -0400
Message-ID: <1276612389.2749.38.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-06-14 at 21:42 -0700, Casey Schaufler wrote:
> Eric Paris wrote:
> > On Mon, 2010-06-14 at 10:48 -0400, Stephen Smalley wrote:
> >   
> >> On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> >>     
> >>> There is interest in being able to see what the actual policy is that was
> >>> loaded into the kernel.  The patch creates a new selinuxfs file
> >>> /selinux/policy which can be read by userspace.  The actual policy that is
> >>> loaded into the kernel will be written back out to userspace.
> >>>       
> >> Why a new node vs a read op for /selinux/load?
> >>     
> >
> > No reason why I couldn't.  Just 'load' seemed to imply a connotation
> > which wasn't appropriate.  If you prefer I'll switch it when I do
> > another version.
> >   
> 
> If it makes any difference Smack /smack/load does read as well as write.
> You have the opportunity to make 2 or 3 users less confused if you do
> things consistently. After all, Smack uses load because SELinux does,
> the name is actually arbitrary, and why do something differently when
> it doesn't really matter?

I did two things yesterday.  First I switch the read
from /selinux/policy to /selinux/load.  Then I undid that change and
started generating the in kernel policy buffer on open() rather than on
read().  It allowed me to use cat /etc/policy > policy rather than using
my own half ass hacked utility.  The reason I undid the policy->load
change was because I didn't really want to store the old policy on open
if they were going to write() a new policy.  I can probably make the
determination based on the f_mode, but didn't really play with it yet.
I  try to do both in the next go-round.

I'm still trying to figure out what I did to make malformed policies.
Must have screwed something up ripping out my prink's and debug hooks,
because it isn't working for me now either....

Unrelated note, can we take patches 1,2,3 ?  They are just cleanups....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
