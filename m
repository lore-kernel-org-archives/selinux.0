Subject: Re: Announce: Updated SELinux conditional policy extensions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Selinux Dev <selinux-dev@tresys.com>
In-Reply-To: <1074631222.31819.127.camel@moss-spartans.epoch.ncsc.mil>
References: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
	 <1074631222.31819.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074632549.13451.16.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 16:02:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-01-20 at 15:40, Stephen Smalley wrote:
> On Wed, 2004-01-14 at 16:06, Karl MacMillan wrote:
> > This release includes modifications to the linux kernel, checkpolicy,
> > libselinux, and the default policy and allows the creation and loading
> > of conditional policies. Any testing or feedback would be greatly
> > appreciated.
> 
> At least until fine-grained labeling support exists for selinuxfs, I'd
> suggest adding a new permission for controlling writes to your booleans
> rather than re-using setenforce, as the latter conveys too much power. 
> Even if fine-grained labeling support is added, you may still want to
> retain such a permission to provide a coarse-grained first level of
> control over who can set the booleans.  The two patches below add a
> setbool permission to the kernel and policy for that purpose, and
> adjusts your code to use it instead of setenforce.
> 

Sounds good - I put that in as a temporary measure until the
fine-grained labeling came along, but I agree that this is better and
that this is a good thing to keep permanently.

Thanks,

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
