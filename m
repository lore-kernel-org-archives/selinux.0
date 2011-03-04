Subject: Re: Further questions about configuring contexts differently for
 variant classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux-mailing-list
 <selinux@tycho.nsa.gov>,
        refpolicy@oss1.tresys.com
In-Reply-To: <SNT139-w62C8D0A475883C71AD50F9ABC20@phx.gbl>
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
	 <1298554512.31953.38.camel@moss-pluto>,<4D667EBA.3060205@tresys.com>
	 <SNT139-w62C8D0A475883C71AD50F9ABC20@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2011 09:04:58 -0500
Message-ID: <1299247498.22127.8.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-04 at 10:38 +0000, HarryCiao wrote:
> Hi Stephen and Chris,
> 
> I would like to dig deeper on this topic and I have started thinking
> below questions as a starting point, it definitively would help me to
> get warmed up quickly if you could help pointing me at the background
> story :-)
> 
> [cut]
> > > ... Maybe we can come up with some generalized
> > > solution that will be more flexible going forward for configuring
> how
> > > different parts of the context are assigned for different classes.
> We
> > > have talked previously about using the role field even for files
> rather
> > > than just making them all object_r.
> > 
> 
> 1. Would it work simply to make the newly created objects have the
> role of "scontext->role" than "object_r" in security_compute_sid?

No, that would break existing policies.  We need a way to allow existing
systems to still use object_r while allowing future policies to leverage
new support for using the role field in object security contexts.  I
sketched one possible approach in the earlier thread that Chris
referenced, i.e. inherit from tcontext->role (parent directory) and add
role transition support on object classes.  Then on existing systems
where directories are labeled object_r, everything will still work as
before, but with new policies, we can set up role transitions on the
file classes to use the subject role where that is desired.

> 2. If files' role is not "object_r" anymore, what changes in refpolicy
> and SELinux kernel space would have to be done accordingly?

In the kernel, we check for OBJECT_R_VAL and exempt security contexts
with that role from the validation checks on user-role, role-type, and
user-range.  So using subject roles on objects will enable that checking
and require that the policy explicitly authorize those pairings.

> ! 3. Where can I find our previously talks on such topic?

Looks like Chris did a good job of hunting down the prior discussions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
