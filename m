Subject: Re: mv and cp behavior.
From: Colin Walters <walters@redhat.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1098123729.10216.6.camel@wintermute.xmldesign.de>
References: <41712EEF.9090402@redhat.com>
	 <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1098115678.6101.30.camel@decepticon.boston.redhat.com>
	 <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil>
	 <1098121436.6101.56.camel@decepticon.boston.redhat.com>
	 <1098123729.10216.6.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 18 Oct 2004 16:24:44 -0400
Message-Id: <1098131084.3777.6.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 20:22 +0200, Erich Schubert wrote:
> Hi,
> btw: an easy way of doing a "cp" without changing destination file
> properties (unix and selinux) is using "cat sourcefile > destfile"

This is actually what cp does now if the file already exists.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
