Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QEAjXZ012459
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 10:10:45 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QEAhT7026228
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 14:10:44 GMT
Date: Tue, 26 Oct 2004 15:21:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
Message-ID: <20041026142126.GC8053@lkcl.net>
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil> <20041022155639.GA4986@lkcl.net> <41796C01.4060909@redhat.com> <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 25, 2004 at 10:52:37AM -0400, Stephen Smalley wrote:
> Let's step back for a moment from the implementation details and talk
> about the concept/usage of this customized flag for SELinux attributes.
> 
> The file_contexts configuration and setfiles were only intended to
> initialize the system, as previously noted.  

 it would appear, therefore, that no provision has been made for
 filesystem recovery.

 i find frequently that ext3 filesystem damage results in fsck.ext3
 going "the extended attributes aren't valid: truncating".

 this leaves you with a (null) for an selinux access, as if you had
 run your system with a non-selinux kernel and written some files.

 under such circumstances, i find that the only [simple] means
 at present to recover such a damaged system is to run setfiles.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
