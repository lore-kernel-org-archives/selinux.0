Subject: Re: Newrole in targeted mode
From: Karsten Wade <kwade@redhat.com>
Reply-To: kwade@redhat.com
To: SELinux@tycho.nsa.gov
In-Reply-To: <1104388628.3140.4.camel@jsingh>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
	 <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
	 <1104388628.3140.4.camel@jsingh>
Content-Type: text/plain
Date: Sun, 02 Jan 2005 03:30:26 -0800
Message-Id: <1104665427.9831.13.camel@erato.phig.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-30 at 12:07 +0530, Jaspreet Singh wrote:
> Hi,
> 
> I tried to search and couldn't find any threads on this question ..
> 
> What are the basic differences between targeted and strict policies ..
> 
> All I know is .. there are lesser targeted domains/roles in target
> policy compared to strict and as a result most domains run in an
> unconfined_t domain.

Everything runs in unconfined_t unless there is a transition specified
to go to the new domain.  This transition is specified for only a small
number of daemons.

Other things are simplified.  In the targeted policy, there are fewer
rules overall, fewer file contexts, and so forth.

> On Tue, 2004-12-28 at 13:50 -0500, Stephen Smalley wrote:
> > newrole serves no purpose under targeted policy; users are unconfined.
> > setenforce 0 should work for you as root (from unconfined_t, of course,
> > which is what you should already be in for a user session).
> 
> You can add new users and roles in target policy also ... 
> In that case newrole should work as per the modified policies .. I am wrong ??

Because processes at all levels, whether spawned by init or a user, run
in the unconfined_t domain, the role has no meaning.  AIUI, a user does
not need an elevated role for what they do.

- Karsten
-- 
Karsten Wade, RHCE, Sr. Tech Writer
a lemon is just a melon in disguise
http://people.redhat.com/kwade/
gpg fingerprint: 2680 DBFD D968 3141 0115  5F1B D992 0E06 AD0E 0C41


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
