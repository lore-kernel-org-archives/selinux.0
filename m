Date: Tue, 11 Dec 2001 12:54:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: RH72 psmisc patch
In-Reply-To: <3C16408B.1010503@pcez.com>
Message-ID: <Pine.GSO.4.33.0112111251370.19311-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 11 Dec 2001, Shaun Savage wrote:

> I upgraded to the new selinux-20011210.....
> I found a problem with the fileutils patch i submitted yesterday.  'df'
> security segfaults.

Yes, the df modifications didn't transfer well into fileutils-4.1, and we
haven't looked into the problem yet.  Consequently, the df modifications
aren't in the modified fileutils-4.1 package in the new SELinux release.
We still need to compare your fileutils-4.1 patch with our own at
some point to see if there are any other important differences.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
