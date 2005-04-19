From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: I am attempting to add a secadm_r
Date: Tue, 19 Apr 2005 14:32:52 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
References: <425553ED.1040703@redhat.com> <1112893854.27110.66.camel@moss-spartans.epoch.ncsc.mil> <42558933.7050605@redhat.com>
In-Reply-To: <42558933.7050605@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504191432.56810.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 April 2005 05:25, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Ok, this is the point I was trying to understand.  I was hoping I could
> define a role without defining
> an initial type.  I was hoping for secadm_r:sysadm_t or
> secadm_r:staff_t.  Forcing a new initial type,
> seems a little touch.  This causes the creation of new roles to be more
> difficult.
>
> I would have thought you could define a staff_t and then depending on
> which roles they were currently
> under, which domains they could reach.
>
> So staff_r:staff_t can not add users.
> But useradd_r:staff_t can.

Sure that could be done:

domain_auto_trans(staff_t, useradd_exec_t, useradd_t)
role staff_secadm_r types useradd_t;

But I agree with Steve that it doesn't offer much.  Having a separate initial 
domain for such operations makes more sense.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
