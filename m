Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 12:15:22 -0500
Message-Id: <1112202922.8012.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 09:04 -0800, Casey Schaufler wrote:
> Well, the old unix way was for them to run as
> a normal (unprivileged) user. No privilege, no
> problem, right?

Did you miss the desktop talk at the SELinux symposium?  
http://www.selinux-symposium.org/2005/presentations/session3/3-1-walters.pdf

> Is DTE application transparent or does it require
> modification to the applications? If the latter
> your proposals are reasonable but the whole DTE
> scheme is more sophisticated than it needs to be.
> If the former, you need to relax your expectations
> of application behavior and work harder on the
> policy you want to impose.

TE (not DTE, different beast, ask me privately if you want a comparison
paper) can operate transparently to the application, but you often can't
achieve true least privilege without application modifications or
changes in its conventional usage.  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
