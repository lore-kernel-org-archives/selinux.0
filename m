Subject: Re: making progress...a few comments..
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Mark Shakespeare <mshakes@llnl.gov>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1075392482.21044.108.camel@moss-spartans.epoch.ncsc.mil>
References: <p06020408bc3db651f5a5@[128.115.96.64]>
	 <1075391927.13803.98.camel@colossus.columbia.tresys.com>
	 <1075392482.21044.108.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1075392994.13803.109.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 11:16:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-29 at 11:08, Stephen Smalley wrote:
> On Thu, 2004-01-29 at 10:58, Karl MacMillan wrote:
> > If it works
> > with checkpolicy, please send me the policy.conf because that version of
> > seaudit should handle anything that checkpolicy does with the exception
> > of the two new features that Steve just added ('-' and typealias).
> 
> Dan already added the type exclusion ('-') support to his checkpolicy
> package and it is being used by his policy package to exclude shadow_t
> from certain sets.

That is probably what the problem is then. Support for this is coming,
but we are taking time to make certain that it is thoroughly tested
before release as it impacts all of the analysis capabilities of our
tools.

Karl

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
