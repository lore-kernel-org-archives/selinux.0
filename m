Subject: Re: [SEMANAGE] Further header cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <439FCDA2.2000504@cornell.edu>
References: <439FCDA2.2000504@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:20:58 -0500
Message-Id: <1134573658.3421.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-14 at 02:45 -0500, Ivan Gyurdiev wrote:
> Complete changes began by previous patch(es) (things that were missed):
> 
> The internal header should not precede polymorphic definition in:
> user_record.c
> seuser_record.c
> iface_record.c
> boolean_record.c
> 
> Include guards added for:
> context_internal.h
> 
> typedef define guard added for:
> port_record.h
> (and include port_internal.h in port_record.c)
> =========
> Then... move all extern declarations of the record method table
> into the internal header where they belong - that requires including
> database.h, but that's okay, because the previous patches fixed
> issues relating to that.

Thanks, merged as of libsemanage 1.5.3.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
