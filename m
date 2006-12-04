Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB5FrtN0004331
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 10:53:55 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB5FrE8V001640
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 15:53:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kB5FpNB5004481
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 10:51:23 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kB5FpNc4004480
	for selinux@tycho.nsa.gov; Tue, 5 Dec 2006 10:51:23 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4Nc9dS009856
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 18:38:09 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4NbTBf023574
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 23:37:29 GMT
From: "David O'Brien" <david.obrien@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: User home directory creation with useradd (rhbz#217441)
Date: Tue, 5 Dec 2006 09:38:29 +1000
Cc: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
References: <1165003691.18588.103.camel@code.and.org> <200612041239.21597.david.obrien@redhat.com> <45742770.50001@mentalrootkit.com>
In-Reply-To: <45742770.50001@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612050938.29569.david.obrien@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 December 2006 23:49, Karl MacMillan wrote:
> David O'Brien wrote:
> > On Saturday 02 December 2006 06:22, Karl MacMillan wrote:
> >>> 4. Document that you need to call the list of programs in #3.
> >>
> >> Nobody reads documentation - this isn't viable.  <--------  !!
> >
> > Karl... be nice. Tech writers are sensitive beings  ;-)
>
> Sorry! What I really should have said is, people don't normally find
> features through documentation. Rather, they resort to docs once what
> they have found doesn't work correctly. So in this case, if the features
> aren't part of useradd it is unlikely they will find semanage or any
> other SELinux feature.
>
> Karl

/me re-emerges from shell...  :-)

I'm pretty familiar with it. "When all else fails, read the doc."

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
