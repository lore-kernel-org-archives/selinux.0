Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RIAIXZ023126
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:10:18 -0400 (EDT)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RI9xFj013491
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 18:10:15 GMT
Message-ID: <417FE499.3040405@trustedcs.com>
Date: Wed, 27 Oct 2004 13:10:33 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] devpts xattr support
References: <Xine.LNX.4.44.0410271028050.9447-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0410271028050.9447-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> What other filesystems are likely to need xattr handlers?  It is (now 
> especially) very simple to add them as needed.
> 

All filesystems (and file types) will need that support.  Basically, 
getfilecon should never be unable to retrieve a context for a valid file 
because there actually *is* a context associated with every file, and it 
is being used for access decisions.
Just think if every file had the standard DAC info, but you could only 
see/modify that info on certain filesystems - you may scratch your head 
for a while trying to figure out what is causing access denials.

> I think we should stick with the xattr API, it is "the" way to manage
> extra-inode data under Linux.  Perhaps what we should do instead is fix
> the core xattr code so that it can do what we need it do to.

I'm all for that.  I will play around with a few ideas and see if I can 
come with anything useful.  I'm thinking along the lines of the 
permission call which uses i_op->permission if it exists and falls back 
to vfs_permission if it does not.  Maybe we can create a fallback for 
*xattr...

Thanks everyone for the feedback.

-- 

Darrel Goeddel
Senior Secure Systems Engineer

Trusted Computer Solutions             E: dgoeddel@trustedcs.com
121 West Goose Alley                   V: 217.384.0028 x19
Urbana, IL  61801                      F: 217.384.0288

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
