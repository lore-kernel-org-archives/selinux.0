Subject: Re: PT_GNU_STACK RWE
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108946955.9501.7.camel@cobra.ivg2.net>
References: <1108946955.9501.7.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 08:56:19 -0500
Message-Id: <1109080579.2256.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-02-20 at 19:49 -0500, Ivan Gyurdiev wrote:
> Some of those are causing trouble, just like java.
> They produce the same kind of denials as a legacy domain
> where you say READ implies EXEC for backwards compatibility. 

Yes, PT_GNU_STACK RWE means that it has been marked as requiring
executable stack, so you end up with the same issues as in the case
where it has no marking and is assumed to require it for backward
compatibility.  In general, you want to check each one to see whether it
truly requires executable stack or just needs to have its build fixed,
and if the former, move into a separate domain.  Or, alternatively,
introduce the legacycompat support I mentioned in a previous email to
have SELinux only check based on the requested protection, not the
kernel-augmented one.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
