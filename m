Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77D6xVZ019072
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 09:06:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l77D6wVa010838
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 13:06:58 GMT
Subject: Re: Application_domain
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B1F9CD.5070202@redhat.com>
References: <46B1F9CD.5070202@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 09:06:20 -0400
Message-Id: <1186491980.18881.15.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 11:35 -0400, Daniel J Walsh wrote:
> My definition of the application domain, is any file that a normal
> user is expected to execute.   It can either have a  transition or
> not.  If I define application_domain then it will transition.  If I
> just define application_executable_file, then logged in users can
> execute it without a transition.
> 
> Daemons for the most part should NOT be application_domains.   This
> way we can dontaudit getattr of daemons that users would/should not be
> allowed to execute.
> 
> Some applictions can be in both domains.  For example cvs, rsync can
> be run without transitioning by users but when run from an initscript
> they transition.
> 
> This patch makes changes to the pool to match this.

If you look back at what you're changing, init_system_domains() are all
apps, so the call is in that interface.  Your patch undoes this.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
