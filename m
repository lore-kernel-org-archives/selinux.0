Subject: Re: capability audit_write, audit_control
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1129917894.27663.114.camel@moss-spartans.epoch.ncsc.mil>
References: <1129896530.2375.556.camel@moss-spartans.epoch.ncsc.mil>
	 <200510211644.j9LGiaen007329@mms-r01.iijmio.jp>
	 <1129917894.27663.114.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 14:09:19 -0400
Message-Id: <1129918159.27663.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 14:05 -0400, Stephen Smalley wrote:
> > And make reload was success, and I saw grant log of ssh_t's audit_control.
> > Following is my strict policy and checkpolicy version.
> > # rpm -q selinux-policy-strict checkpolicy
> > selinux-policy-strict-1.23.16-6
> > checkpolicy-1.23.1-1
> 
> Hmm...I suspect a problem in the assertion checker in that version,
> although I'm not sure.  I get an assertion failure with the current
> checkpolicy if I add that neverallow rule to my policy.

Hmmm...tried on a FC4 system, and still get the assertion failure.

libsepol-1.5.10-1.1
checkpolicy-1.23.1-1
selinux-policy-strict-1.27.1-2.6

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
