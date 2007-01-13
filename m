From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] clarifications for -l to newrole.1
Date: Sat, 13 Jan 2007 17:26:27 +1100
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Klaus Weidner <klaus@atsec.com>
References: <45A6A064.2040707@us.ibm.com> <200701120907.10944.russell@coker.com.au> <1168612577.7993.477.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168612577.7993.477.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701131726.34089.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 13 January 2007 01:36, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > MCS as currently released in Red Hat and Debian only uses the high level.
> >  MCS will always use the high level as the main access control mechanism.
> > Therefore this behaviour gets in the way for MCS.
> >
> > Maybe we should have newrole determine whether MCS or MLS is being used
> > and alter it's behaviour accordingly?
>
> Under MCS, IIUC, one never switches the level on a process; your
> sensitivity (low) is always set to SystemLow and your clearance (high)
> is just set to your authorized category set at login, and you manually
> use chcat or similar commands to label files with categories.  So you
> wouldn't use newrole -l at all under MCS.

That's the way it currently works.  I want to change that however, I hope to 
get such changes in Debian soon.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
