Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96A0CrT003099
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 06:00:12 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96A0BKB002494
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 10:00:11 GMT
Date: Wed, 6 Oct 2004 11:10:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
Message-ID: <20041006101046.GA5790@lkcl.net>
References: <200409292354.15227.russell@coker.com.au> <200409300620.41527.russell@coker.com.au> <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil> <200410020344.04225.russell@coker.com.au> <1096920735.3235.17.camel@moss-lions.epoch.ncsc.mil> <4162C0C6.9090704@redhat.com> <1097003202.30738.35.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1097003202.30738.35.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

james, i didn't see a reply to your question about whether
it was mozilla that defined the "~/My Downloads" directory:
did i miss something?

i appreciate the issues of needing, ultimately, some helper-program
intervention which determines (saaay... by asking for the user's
password) whether a file should be saved with a file context of
user_mozilla_t or user_home_t.

and that there needs to be a sandbox area in which files should be
saved.

... but does it _have_ to be in ~/My windows style downloads???


On Tue, Oct 05, 2004 at 03:06:42PM -0400, James Carter wrote:
> Merged.  
> 
> There are some minor changes such as My.Downloads instead of My
> Downloads and not having {} around a single item.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
