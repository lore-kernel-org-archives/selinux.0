Subject: Re: Correct manner to handler undefined classes/permissions? (Re:
 Some ideas in SE-PostgreSQL enhancement)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <49D3171A.3020708@ak.jp.nec.com>
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>
	 <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
	 <49D3171A.3020708@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 08:45:35 -0400
Message-Id: <1238589935.24074.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-01 at 16:26 +0900, KaiGai Kohei wrote:
> > 5. Handle unsupported object classes/access vectors
> > 
> > What is the correct behavior for userspace object managers,
> > when it tries to check undefined object classes or access
> > vectors?
> > 
> > For example, we don't define db_database:{superuser} in the
> > security policy. We cannot decide whether it is denied, or not.
> > How the SE-PostgreSQL should perform for this?
> > 
> > In the current implementation, it simply ignores undefined
> > permissions because string_to_av_perm() cannot return a valid
> > access vector.
> > 
> > One possible idea is it performs according to /selinux/deny_unknown.
> > If so, a new interface on libselinux is desirable.
> 
> This topic has been left for a week.
> 
> How should it be handled when we cannot find required classes or
> permissions in the security policy?
> 
> The kernel allows anything or nothing for undefined object classes
> based on policydb.allow_unknown. However, if the security policy
> does not have a definition of the required access vector, it is
> always denied (due to lack of explicit permission).
> 
> My preference is filling up the undefined access vectores with
> policydb.allow_unknown. It seems to me quite natural.

I believe that is what the kernel does during policy load, by defining
the policydb->undefined_perms[] array.

> Userspace object managers also have same issue.
> Now it's unclear for me what is the preferable behavior.
> For example, how should it handle the db_database:{superuser}
> on the older security policy?
> 
> Thanks,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
