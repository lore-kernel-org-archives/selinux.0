Date: Thu, 9 May 2002 10:31:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Davies, James E" <jedavie@sandia.gov>
cc: "'Selinux@tycho.nsa.gov'" <Selinux@tycho.nsa.gov>
Subject: Re: new selinux install
In-Reply-To: <B51F0C636E578A4E832D3958690CD73EBB102D@es04snlnt>
Message-ID: <Pine.GSO.4.33.0205091026000.1046-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 9 May 2002, Davies, James E wrote:

> May  9 04:47:03 bilbo kernel: security:  6 users, 5 roles, 406 types
> May  9 04:47:03 bilbo kernel: security:  29 classes, 43869 rules

Actually, looking at this output, I'd guess that you are not using the
latest release (May 2nd - 2002050211) but are instead using the previous
release (March 14th - 2002031409).  If so, you need to do a 'make relabel'
in selinux/setfiles, not selinux/policy, in order to label your filesystem.
The file contexts configuration was moved between those two releases.  Of
course, you may simply want to upgrade to the latest release and install
again.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
