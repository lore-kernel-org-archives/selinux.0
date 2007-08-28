MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Looks like we have a 64 bit problem on Rawhide.
Date: Tue, 28 Aug 2007 12:55:54 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010085CB@exchange.columbia.tresys.com>
In-Reply-To: <46D44D99.9020405@redhat.com>
References: <46D44D99.9020405@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmill@redhat.com>,
        "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> libsepol.module_package_read_offsets: offsets are not increasing (at
> 2, offset 61226322186831055 -> 0
> 
> rpm -q libsepol
> libsepol-2.0.7-1.fc8
> 
> Can't update policy on x86_64 machines.

It looks like "off" in module_package_read_offsets() should
be unsigned, not size_t.  Right now there is a 32 vs. 64 bit
mismatch. 

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
