Subject: Re: Proposed patch to lisemanage/policycoreutils patches to not
	run genhomedircon/setfiles when setting booleans.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <469E6FFF.3040009@redhat.com>
References: <469E6FFF.3040009@redhat.com>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 13:55:24 -0400
Message-Id: <1184954124.17338.868.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-18 at 15:54 -0400, Daniel J Walsh wrote:
> Takes about 2 seconds off the time to rebuild policy and lots more if 
> you are backending your passwd database with ldap.  Or have many 
> different locations for homedirs.

The way this should work is libsemanage should internally know what
needs to be rebuilt and only rebuild those things.  Not require the
caller to enable/disable parts.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
