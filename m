Message-Id: <200510211932.j9LJWT3Y022912@mms-r00.iijmio.jp>
Date: Fri, 21 Oct 2005 15:31:56 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: capability audit_write, audit_control
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1129918159.27663.117.camel@moss-spartans.epoch.ncsc.mil>
References: <1129918159.27663.117.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-10-21 at 14:05 -0400, Stephen Smalley wrote:
> > > And make reload was success, and I saw grant log of ssh_t's audit_control.
> > > Following is my strict policy and checkpolicy version.
> > > # rpm -q selinux-policy-strict checkpolicy
> > > selinux-policy-strict-1.23.16-6
> > > checkpolicy-1.23.1-1
> > 
> > Hmm...I suspect a problem in the assertion checker in that version,
> > although I'm not sure.  I get an assertion failure with the current
> > checkpolicy if I add that neverallow rule to my policy.
> 
> Hmmm...tried on a FC4 system, and still get the assertion failure.
> 
> libsepol-1.5.10-1.1
> checkpolicy-1.23.1-1
> selinux-policy-strict-1.27.1-2.6

My strict policy was old, so I've updated to 1.27.1-2.6 now, 
checkpolicy and libsepol is the same as yours.

1)
I commented out following from global_macros.te
#allow $1 self:capability { audit_write audit_control };
#allow $1 self:capability { audit_write audit_control };

It is just for test.

2)
add following.
auditallow sshd_t self:capability { audit_control };
neverallow sshd_t self:capability audit_control;

3) 
#make reload
It was success.

4) Login to ssh
5) I saw following log.
audit(1129922556.917:12): avc:  granted  { audit_control } for  pid=2315 comm="sshd" capability=30 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=capability

Isn't it strange?

Now I found my kernel is old too(2.6.12-1.1398_FC4), 
I will update kernel and test it again.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
