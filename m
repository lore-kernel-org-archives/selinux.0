Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFp8rT027865
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:09 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFp7CV008190
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:51:07 GMT
Date: Tue, 24 Aug 2004 15:57:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: patch for ssh-agent
Message-ID: <20040824145753.GG4698@lkcl.net>
References: <20040823215904.GE13677@lkcl.net> <1093346501.1800.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093346501.1800.23.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 07:21:41AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-23 at 17:59, Luke Kenneth Casson Leighton wrote:
> > absolutely clueless as to what this is for, but at least it gets
> > rid of the audit warnings, which were bugging me.
> 
> libselinux constructors try to:
> - determine where selinuxfs is mounted via /proc/self/mounts for future
> use in libselinux calls that act on selinuxfs,
> - determine where the "active" policy is located via /etc/selinux/config
> for future use in libselinux calls that act on policy files.
> 
> As a result, anything that links with libselinux will trigger these
> access attempts upon startup, even if the program never subsequently
> invokes any libselinux calls that would act on selinuxfs or a policy
> file.  If you know the program isn't using such calls, then you can just
> dontaudit these rules.
 
 oo.  okay.
 
 well, i added dontaudit for ssh-agent and well it seems to be okay.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
