Subject: Re: [ libsemanage ] Key extract function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, jbrindle@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1122670387.28860.43.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
	 <1122665303.28860.30.camel@celtics.boston.redhat.com>
	 <1122670387.28860.43.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 09:17:47 -0400
Message-Id: <1122988667.11904.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 16:53 -0400, Ivan Gyurdiev wrote:
> The following patch implements the key extract function.
> The key is basically the part of the record that uniquely identifies
> it in a collection of the same records. This introduces the
> concept of a record collection in libsepol, which may be
> the wrong place for it, but I think for now it should stay there.
> 
> This patch provides a way to obtain the key given the data structure.
> 
> The key is part of the data structure, which may seem unnecessarily
> redundant, but I think it's the right interface - we may choose to
> change this behavior in the future, and it just seems wrong to pass
> a data structure partially filled as the key to functions like
> query() or destroy() (in semanage).

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
