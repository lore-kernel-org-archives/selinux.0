Date: Tue, 2 Nov 2004 17:01:44 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: What policy is the system running?
In-Reply-To: <4187DEA1.8080407@redhat.com>
Message-ID: <Xine.LNX.4.44.0411021651060.10659-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Nov 2004, Daniel J Walsh wrote:

> Ideas???

We could do an md5 checksum of the binary policy as it is written to 
/selinuxfs/load then export this via /selinux/policy_md5sum.

This would allow you to determine which policy is loaded.  Each binary 
policy module could be similarly checksummed.


- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
