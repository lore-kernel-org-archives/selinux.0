Subject: Re: Q on the Constrain verb
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200308190127.27853.wlsel@verizon.net>
References: <200308190127.27853.wlsel@verizon.net>
Content-Type: text/plain
Message-Id: <1061298543.25048.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 Aug 2003 09:09:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-08-19 at 01:27, Bill Laut wrote:
> I'm writing up a .te file for the Tripwire suite.  I'd like the policy to 
> distinguish between staff_r and sysadm_r, in that sysadm_r is given 
> unrestricted access to create/modify the Tripwire policy, database, and 
> local/site keys.  Staff_r (and initrc_t) are given read-only access to these 
> files, so that automated nightly and/or staff security checks are not allowed 
> to potentially alter the Tripwire database/policy.
> 
> I would like to use the constrain verb in my .te file to distinguish sysadm_r 
> from all others, but when I do a "make reload" I get a syntax error on the 
> constrain statement.  I've even gone so far as to quote the third example 
> constrain statement (pg. 20, Sec. 4.5 of "Configuring the SELinux Policy") 
> verbatim in my .te file, but it, too, generates a syntax error.

Constraints are separate from the TE configuration, and are placed in
the policy/constraints file.  In any event, I think you are using the
wrong mechanism for what you are trying to achieve.  If you want to
grant different permissions for sysadm_r vs. staff_r, then do so by
granting different permissions to sysadm_t vs. staff_t, e.g. staff_t is
only given read permission to the tripwire types, and cannot perform a
domain transition to any of the domains that can write to the tripwire
types.  You can also limit all domains that can write to the tripwire
types to the sysadm_r role.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
