Subject: Re: I would like to propose some kind of consolidation of tmpfs_t
	and tmp_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>
References: <4242CABC.70400@redhat.com>
	 <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 09:44:06 -0500
Message-Id: <1111675446.12486.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 09:37 -0500, Stephen Smalley wrote:
> The concern with collapsing tmpfs_t and tmp_t together (and $1_tmpfs_t
> and $1_tmp_t as well, to avoid type transition conflicts, which would
> occur quite extensively with strict policy) is that it means that policy
> can no longer distinguish between a domain's ability to act on /tmp
> files versus its ability to act on shared memory objects (aside from the
> additional controls on System V shared memory).  If everyone were using
> tmpfs /tmp, that might be less of a concern, as a tmpfs file is
> effectively a shared memory object too.  But if some people still want
> to use a traditional /tmp, then they might care about the distinction.

The other point to note is that programs sometimes create /tmp files
purely for private state with no intent of sharing it with anyone else,
whereas they create shared memory objects for the purpose of sharing, so
collapsing the two together in policy would prevent such distinctions.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
