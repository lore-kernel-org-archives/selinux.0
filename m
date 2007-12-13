Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDEfT0o021754
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 09:41:29 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBDEfQ1s012158
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 14:41:27 GMT
Received: by nf-out-0910.google.com with SMTP id k4so672482nfd.4
        for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 06:41:26 -0800 (PST)
Message-ID: <cadfc0e40712130641r301dd959x895f33ff1e72f581@mail.gmail.com>
Date: Thu, 13 Dec 2007 08:41:26 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: newrole in the background
Cc: "Reed, Tim (US SSA)" <tim.reed@baesystems.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
	 <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com>
	 <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net>
	 <476047A9.90000@gmail.com>
	 <436A69503F99214D9EBC27415F66C40C0F517AD3@blums0008.bluelnk.net>
	 <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Dec 13, 2007 8:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2007-12-13 at 04:30 -0800, Reed, Tim (US SSA) wrote:
> > Good point.  That is why I was looking for test cases or something.
> >
> > I am going to explore Stephen suggestion more of making the lack of a
> > tty non-fatal.  But won't we want newrole to have a tty so that it can
> > send/receive input from the user?  That is the reason why I was having
> > it creating a pseudo tty.
> >
> > Suggestions.....
>
> You said you wanted to be able to use newrole while detached from any
> tty, thus no input is possible there.  Right?
>
> So if you have newrole or the subsequent application use a pam module
> that requires a tty, it is going to fail regardless in that situation.
> Your situation presumes that you aren't using pam modules that require a
> tty.
>
> Only thing to check is to make sure that the pam modules fail gracefully
> in that situation and newrole correctly exits with an error in that
> case.
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

Right, but doesn't pam_unix exec unix_chkpwd and wait for it to exit?
Or will unix_chkpwd fail because there isn't a tty?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
