Subject: Re: SELinux configuration problems on Fedora Core 6
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <385971.61397.qm@web86907.mail.ukl.yahoo.com>
References: <385971.61397.qm@web86907.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 08:49:40 -0400
Message-Id: <1174308580.22565.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-15 at 15:38 +0000, JanuGerman wrote:
> ...sorry to mention one thing that:
> 
> newrole -r SysAdmin_r is also not working and giving
> the error:
> 
> 'couldn't get default type'

The default policy in Fedora is "targeted", not "strict", and thus has
no notion of user roles and types (yet).  If you want those, you
presently need to switch to strict policy.  See the Fedora SELinux FAQ.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
