Subject: Re: making progress...a few comments..
From: Karl MacMillan <kmacmillan@tresys.com>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <p06020408bc3db651f5a5@[128.115.96.64]>
References: <p06020408bc3db651f5a5@[128.115.96.64]>
Content-Type: text/plain
Message-Id: <1075391927.13803.98.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 10:58:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 14:20, Mark Shakespeare wrote:
> Been trying to automate the build process for a Fedora/Selinux system.
> I'am also aware that Fedora core release 2 is coming in April and will
> have Selinux integrated in it.

> seaudit fails...something about a bad policy.conf file...
> 
> 

Do you mean that it says that the policy.conf file is bad and that you
need to exit the application? If so, this is normal behavior for bad
policies (the bug that causes you to have to restart seaudit and apol
when you encounter a bad policy has been fixed for the next release,
however). Does the policy.conf file work with checkpolicy? If it works
with checkpolicy, please send me the policy.conf because that version of
seaudit should handle anything that checkpolicy does with the exception
of the two new features that Steve just added ('-' and typealias). 

Karl 

> The also appears to be no logging for selinux related events.
> 
> 
> Any suggestions are welcome.
> 
> 
> Thanks.
> 
> 								Mark
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
