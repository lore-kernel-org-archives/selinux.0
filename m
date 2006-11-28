Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kASFaJAg009040
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 10:36:19 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kASFZbIV019612
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 15:35:37 GMT
Subject: Re: [RFC] Thunar filesystem manager policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611280651w7e9b0f8fp8a321f8c8b40513b@mail.gmail.com>
References: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
	 <1164637648.7490.18.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280651w7e9b0f8fp8a321f8c8b40513b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 10:36:40 -0500
Message-Id: <1164728200.8768.9.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-28 at 14:51 +0000, Bradley Chapman wrote:
> On 11/27/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > On Wed, 2006-11-22 at 19:41 +0000, Bradley Chapman wrote:
> > > I'm currently writing a policy for the Thunar filesystem manager, and
> > > at the moment I'm having trouble making the policy work. I feel that
> > > it has something to do with the following error message:
> > >
> > > audit(1164224019.042:744): security_compute_sid:  invalid context
> > > staff_u:sysadm_r:thunar_t for scontext=staff_u:sysadm_r:thunar_t
> > > tcontext=system_u:object_r:thunar_exec_t tclass=process
> >
> > Its because of this:
> >
> > domain_auto_trans($2, thunar_exec_t, thunar_t)
> >
> > it should be:
> >
> > domain_auto_trans($2, thunar_exec_t, $1_thunar_t)
> >
> > Why is there a thunar_t and $1_thunar_t?
> 
> Because I want to be able to provide per-user roles; the program is
> designed to run as part of the windowing environment and not
> necessarily asa standalone program.

That explains the $1_thunar_t, but what about thunar_t?  From the
policy, it looks like a daemon.

> > > Also, I'm having trouble getting the D-BUS daemons to transition into
> > > my new policy domain when they start Thunar; how does one configure a
> > > new policy to allow domain transitions of this type?
> > >
> > > The policy files at the end of this message contain the policy I've
> > > managed to create to date. It partially works, but until i fgiure out
> > > the above issues I doubt I can make it work correctly. Criticism is
> > > VERY welcome!
> >
> > There are several types that look like they aren't needed, since they
> > don't have any rules, especially thunar_lib_t.  Also, I wouldn't think
> > the thunar_etc_t would be writable.
> 
> I added these types mainly because thunar_lib_t is assigned to
> executable script files used by the program.

As I noted before, there are no rules for this.  Because of
libs_exec_lib_files(thunar_t), it seems to me that these scripts were
actually labeled lib_t.  My feeling is that this extra type is not
needed, and the scripts might be better off as bin_t.

>  thunar_etc_t, OTOH, was
> added mainly because I didn't want to give Thunar full access to /etc.

It seems very odd to me that a user application would be writing to
files in /etc.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
