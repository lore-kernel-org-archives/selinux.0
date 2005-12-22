Subject: Re: [patch] sereference: permit reiserfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
In-Reply-To: <20051221224720.GA6885@sergelap.austin.ibm.com>
References: <20051221224720.GA6885@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 08:56:40 -0500
Message-Id: <1135259800.951.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 16:47 -0600, Serge E. Hallyn wrote:
> Oops, I forgot about this one...
> 
> Is there still a good reason to not support labeling reiserfs?  If not,
> the following trivial patch was needed for me to 'make relabel' out of
> the reference policy.

The status of reiserfs and SELinux has always been up in the air; SuSE
did some work that went into 2.6.12 that allegedly solved the deadlock
and permission problems, but I don't have any actual reports that anyone
has ever been able to get reiserfs working properly in Fedora with
SELinux enabled, and support for reiserfs would have been broken again
by the removal of the post_create hooks in 2.6.14, see
http://marc.theaimsgroup.com/?l=selinux&m=112653995009765&w=2

Note that since I posted the above referenced message, the xfs
maintainers have implemented a workaround in xfs that should go into
2.6.16.  So only reiserfs will remain broken at that point (unless the
reiserfs maintainers fix it).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
