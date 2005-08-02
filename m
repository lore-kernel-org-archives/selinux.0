Subject: Re: [ libsemanage ] Relay libsepol records
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, jbrindle@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1122665303.28860.30.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
	 <1122665303.28860.30.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 09:17:36 -0400
Message-Id: <1122988656.11904.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 15:28 -0400, Ivan Gyurdiev wrote:
> The following patch relays records in libsemange to
> the ones in libsepol - depends on previous patch for libsepol.
> 
> Records being added will be used in the future.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
