Subject: Re: [PATCH] sepolgen fix tests and refpolicy formatting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1174423342.31342.21.camel@localhost.localdomain>
References: <1174423342.31342.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 10:33:02 -0400
Message-Id: <1174487582.22565.381.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-20 at 16:42 -0400, Karl MacMillan wrote:
> The changes I made to match sepolgen policy output with the refpolicy
> missed type transition rules and broke the unit tests. This patch fixes
> those two problems.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
