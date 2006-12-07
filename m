Subject: Re: [redhat-lspp] pam_namespace is broken from an SELinux
	perspective.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1165521862.12263.127.camel@moss-spartans.epoch.ncsc.mil>
References: <4576E34D.1030105@hp.com> <45783EA8.5080701@redhat.com>
	 <1165513002.12263.69.camel@moss-spartans.epoch.ncsc.mil>
	 <200612080634.23288.russell@coker.com.au>
	 <1165521862.12263.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 15:11:56 -0500
Message-Id: <1165522316.12263.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-12-07 at 15:04 -0500, Stephen Smalley wrote:
> On Fri, 2006-12-08 at 06:34 +1100, Russell Coker wrote:
> > On Friday 08 December 2006 04:36, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > You could work around it by labeling the top-level directories like /tmp
> > > and /home/dwalsh with other types (e.g. poly_tmp_t, poly_home_t)
> > > distinct for polyinstantiated directories, and then define type_member
> > > rules on those, e.g. type_member staff_t poly_tmp_t:dir tmp_t;
> > > type_member staff_t poly_home_t:dir staff_home_dir_t;
> > 
> > The problem with this is that it makes installation of poly-instantiated 
> > directories more difficult.
> > 
> > I would like to see the installation process be as easy as possible to 
> > encourage people who aren't the most capable sys-admins to do it.
> 
> The alternative, as I said, is a simple kernel patch to trigger level
> instantiations even if the new type is the same as the old in the
> type_member rule.  Then you can have type_member staff_t tmp_t:dir
> tmp_t; if you don't want per-role instantiation of /tmp or type_member
> staff_t tmp_t:dir staff_tmp_t; plus additional policy to enable
> applications expecting /tmp to be tmp_t to continue working if you want
> per-role instantiation.  And you would be able to have type_member
> staff_t staff_home_dir_t:dir staff_home_dir_t;.

Note however that the parallel thread on redhat-lspp has proposed using
Dan's patch (with fixes) for now to get the desired behavior for MLS,
renaming the current "context" option in namespace.conf to "level" to be
specific to level instantiation, and later introduce "role" or "context"
for role-based and/or full context instantiation when/if such support
exists in the kernel and/or policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
