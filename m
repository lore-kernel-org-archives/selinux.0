From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
References: <20051009083426.GA10995@localhost.localdomain>
	<1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil>
	<20051011132002.GA6249@localhost.localdomain>
Date: Sat, 29 Oct 2005 11:13:09 -0500
In-Reply-To: <20051011132002.GA6249@localhost.localdomain> (Dave Patterson's
	message of "Tue, 11 Oct 2005 20:20:02 +0700")
Message-ID: <87acgsz4h6.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Oct 2005 20:20:02 +0700, Dave Patterson <sdpatt2@gmail.com> said: 

> And I can see why - Debian's initrd is archaic, so I don't use it
> unless I have to, and udev in our distro is indeed grumpy

        Starting with 2.6.14, Debian has moved away from innitrd to
 initramfs (I think currently the default is to prefer yaird).

        manoj
-- 
The greatest of faults is to be conscious of none.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
