Date: Wed, 30 Oct 2002 17:49:51 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brian May <bam@snoopy.apana.org.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <200210302322.01805.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210301748320.25777-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Russell Coker wrote:

> I'm not sure.  It was my understanding of the conversation between you and
> Steve that some parts of SE Linux will be unconditionally enabled if you
> apply the second patch.  So in my latest kernel patch package I put a bunch
> of extra #ifdef's in...

Yes, this works.  An alternative to #ifdef'ing the inode_init hook is to
simply add trivial stub foo_inode_init hook functions to the DTE and LIDS
modules, like the other hooks that are not truly used by those modules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
