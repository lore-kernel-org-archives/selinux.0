Subject: Re: PT_GNU_STACK RWE
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108946955.9501.7.camel@cobra.ivg2.net>
References: <1108946955.9501.7.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:04:08 -0500
Message-Id: <1109081048.2256.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-02-20 at 19:49 -0500, Ivan Gyurdiev wrote:
> Some of those are causing trouble, just like java.
> They produce the same kind of denials as a legacy domain
> where you say READ implies EXEC for backwards compatibility. 

Note btw that the kernel didn't use to enable read-implies-exec behavior
for PT_GNU_STACK RWE; only for a missing PT_GNU_STACK, but this was
changed recently upstream to deal with compatibility problems.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
