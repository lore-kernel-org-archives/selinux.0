Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m68CuYui029979
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 08:56:34 -0400
Subject: Re: running filecaps ltp test
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net,
        SELinux <selinux@tycho.nsa.gov>, Andrew Morgan <morgan@kernel.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <8671.1215508448@redhat.com>
References: <20080707210741.GA13042@us.ibm.com>
	 <20080707184252.GC22937@us.ibm.com>
	 <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
	 <8671.1215508448@redhat.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:56:32 -0400
Message-Id: <1215521792.27975.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-08 at 10:14 +0100, David Howells wrote:
> Serge E. Hallyn <serue@us.ibm.com> wrote:
> 
> > David, what policy version?
> 
> selinux-policy-3.3.1-72.fc9.noarch
> selinux-policy-targeted-3.3.1-72.fc9.noarch
> selinux-policy-devel-3.3.1-72.fc9.noarch
> 
> Is that what you want to know?

Ok, that's a bug in the Fedora policy, not an upstream issue.
You can work around it by adding it in a local policy module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
