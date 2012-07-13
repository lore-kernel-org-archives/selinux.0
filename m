Message-ID: <1342210967.7054.32.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: The criteria for seandroid policies
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 13 Jul 2012 16:22:47 -0400
In-Reply-To: <CAO-4OdH_vW0TKJDNwKm1HEMxme2DfHzd5YQ5WuGbZOuSO4kvPw@mail.gmail.com>
References: 
	<CAO-4OdH_vW0TKJDNwKm1HEMxme2DfHzd5YQ5WuGbZOuSO4kvPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-13 at 13:15 -0700, Haiqing Jiang wrote:
> Hi, all
> 
> 
> I have a quick question about the seandroid policies: when we
> create/add/refine the security policies, is there any
> principle/model/criteria to follow? For example,
> how to determine the new policies are secure or not, how to determine
> the new policies are reasonable or not， how to determine the new
> policies are user-friendly or not.....
> 
> 
> All those staffs are confusing me. Thanks for your help.  

Our goals for the SE Android policy are to confine the privileged
daemons in Android, ensure that the Android middleware components cannot
be bypassed, and ensure that apps are truly isolated from one another at
the kernel layer.  So when you modify the policy, you have to consider
whether you are subverting one or more of those goals.  When you
encounter a denial, you have to consider the best way to address it.
Sometimes that means creating a new domain or type in the policy to
ensure least privilege.  Sometimes it means altering code, e.g. the
introduction of restorecon calls to ensure that files are properly
labeled.  Sometimes you can just allow the access in the policy.  This
isn't unique to SE Android; you can look to existing documentation,
wikis, blogs, etc on SELinux policy writing for help.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
