Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1MMLXZ001252
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 17:22:21 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1ML0CC010346
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 22:21:00 GMT
Date: Mon, 1 Nov 2004 22:33:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux List <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
Subject: Re: dynamic context transitions
Message-ID: <20041101223306.GO9643@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net> <418662EE.5090001@trustedcs.com> <1099344460.23756.49.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099344460.23756.49.camel@pham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 04:27:40PM -0500, Karl MacMillan wrote:
> Dropping privileges after startup can already be accomplished with
> conditional policies, though it requires that only one process be
> running in a given domain.
 
 sorry to be a pain but i feel a need to clarify: is that most
 definitely the case?

 to illustrate, which of these is true:

 - if i have two processes in a given domain, and one process
   runs the "drop privileges" selinux function, the process calling
   the function has its privileges "dropped" but the other process
   retains the _original_ privileges.

 - if i have two or more processes in a given domain, and one process
   runs the "drop privileges" selinux function, _all_ processes in that
   domain have their its privileges "dropped".

 - something indeterminate happens and it all goes pear-shaped.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
