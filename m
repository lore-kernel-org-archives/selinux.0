Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IGaJc4008204
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 11:36:19 -0500
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0IGbCih021986
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 16:37:13 GMT
Date: Thu, 18 Jan 2007 08:36:56 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
To: Stephen Smalley <sds@tycho.nsa.gov>, Crispin Cowan <crispin@novell.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <1169128425.22731.232.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14268.46782.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> To the contrary, the LSPP work significantly
> leverages the work already
> done to integrate SELinux and makes use of the
> SELinux interfaces for
> applications.  It also leverages SELinux TE to
> address aspects such as
> MLS overrides.  By doing it within the context of
> SELinux, it gained the
> benefit of a unified security model and interface. 
> Which one doesn't get from LSM.

There are others who would argue that SELinux
has abandoned the Linux privilege model and
thus disrupted the unity of the existing
security model.

I don't understand why the SELinux crew seems
so intent on making it difficult to implement
alternatives. Last year it was "let's ditch LSM".
Now it's "Everyone hates stacking". Give it a
rest already.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
