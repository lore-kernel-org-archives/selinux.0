Message-ID: <4D70ED36.7080704@tresys.com>
Date: Fri, 04 Mar 2011 08:46:30 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy@oss1.tresys.com
Subject: Re: Further questions about configuring contexts differently for
 variant classes
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl> <1298554512.31953.38.camel@moss-pluto>,<4D667EBA.3060205@tresys.com> <SNT139-w62C8D0A475883C71AD50F9ABC20@phx.gbl>
In-Reply-To: <SNT139-w62C8D0A475883C71AD50F9ABC20@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/04/11 05:38, HarryCiao wrote:
> Hi Stephen and Chris,
> 
> I would like to dig deeper on this topic and I have started thinking
> below questions as a starting point, it definitively would help me to
> get warmed up quickly if you could help pointing me at the background
> story :-)
> 
> [cut]
>> > ... Maybe we can come up with some generalized
>> > solution that will be more flexible going forward for configuring how
>> > different parts of the context are assigned for different classes. We
>> > have talked previously about using the role field even for files rather
>> > than just making them all object_r.
>>
> 
> 1. Would it work simply to make the newly created objects have the role
> of "scontext->role" than "object_r" in security_compute_sid?
> 2. If files' role is not "object_r" anymore, what changes in refpolicy
> and SELinux kernel space would have to be done accordingly?

We would have to make sure that the file types are associated with each
of the applicable roles.  Probably a little file_context adjustment
w.r.t. genhomedircon.  In the end, not much.

> 3 . Where can I find our previously talks on such topic?

Previous discussions were on the SELinux list

http://marc.info/?l=selinux&m=120948509805194&w=2
http://marc.info/?l=selinux&m=121010532820562&w=2
http://marc.info/?l=selinux&m=121198575124942&w=2
http://marc.info/?l=selinux&m=121313312830959&w=2
http://marc.info/?l=selinux&m=121423386122213&w=2
http://marc.info/?l=selinux&m=121372927211476&w=2
http://marc.info/?l=selinux&m=121622490905223&w=2

Those are all the threads I could find, though there may have been more.

>> It certainly would be nice to have all objects get the role of their
>> creator so we can bring role-based policy separations back using RBAC
>> features and not rely on 1:1 user:role mapping + UBAC.
> 
> 4. It seems that we used to have RBAC, then why we have to have dropped it?
> 5. Does the "1:1 user:role mapping" mean the mapping from linux user to
> selinux user, and the mapping from selinux user to the roles that he/she
> could assume?
> 6. Any discussion email thread about how UBAC works and why we would
> want "1:1 user:role mapping + UBAC"?

If you look at Russell's response, he mentions derived type domains that
have the role encoded in it, eg staff_mozilla_t and user_mozilla_t.
Each of those types was only allowed for the corresponding role, eg
staff_mozilla_t only worked with staff_r.  When we stopped encoding the
role in the types, we wanted to use the role itself to separate
mozilla_t, i.e:

staff_r:staff_mozilla_t -> staff_r:mozilla_t
user_r:user_mozilla_t -> user_r:mozilla_t

and then we would use constraints so that access to and from mozilla_t
would require role equality (i.e the role of the source context has to
equal the role of the target context).  This would remove a significant
amount of policy since each of these derived domains had the same policy
except the role was different.

But this didn't work in the end because when files are created they
always get object_r; they couldn't be configured via a role_transition
to do anything different.  So we had to use the user field.  Its not the
same thing as role separation if a user has more than one role, eg.

staff_u:staff_r:mozilla_t could talk to staff_u:sysadm_r:mozilla_t

but we decided it was ok since general users don't have a problem with,
and the higher assurance people that use selinux usually don't have more
than one role associated with a particular seuser.  What I mean by the
1:1 user:role mapping is that each seuser only has one role.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
