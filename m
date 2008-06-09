Subject: Re: No AVC messages found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30806090915q3092591bqb0f7000b93a0c06c@mail.gmail.com>
References: <dd18b0c30806080143t6d601bacta7b3652331a48dbf@mail.gmail.com>
	 <1213018137.9375.0.camel@moss-spartans.epoch.ncsc.mil>
	 <dd18b0c30806090915q3092591bqb0f7000b93a0c06c@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 12:32:43 -0400
Message-Id: <1213029163.9375.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-09 at 16:15 +0000, Justin Mattock wrote:
> On Mon, Jun 9, 2008 at 1:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On Sun, 2008-06-08 at 08:43 +0000, Justin Mattock wrote:
> >> Hello; why do I receive this: No AVC messages found when I audit2allow -d when
> >> I have this under dmesg:
> >> [ 8395.499759] type=1701 audit(1212909990.108:3): auid=4294967295
> >> uid=1000 gid=1000 ses=4294967295 subj=a-12:sysadm_r:sysadm_t pid=3389
> >> comm="aterm" sig=6
> >>
> >> the only action that I took was "uptime" in a terminal, could this be it?
> >> should I have seen the definition uptime in the AVC? i.g. /usr/sbin or  /*/*
> >> or is this something diff.
> >> regards;
> >
> > Not all audit messages are AVC messages.
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
> 
> Hello; What might have caused this message to be triggered.
> just so I get a better idea.
> regards;

Use /sbin/ausearch -i to interpret the audit messages in a more readable
form.  And ask questions about audit not related to selinux on
linux-audit@redhat.com list after subscribing there.

In this case, type=1701 corresponds to AUDIT_ANON_ABEND in
include/linux/audit.h, which means a process died abnormally.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
