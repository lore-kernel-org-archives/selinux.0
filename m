From: David Howells <dhowells@redhat.com>
In-Reply-To: <453F9555.1050201@wolfmountaingroup.com> 
References: <453F9555.1050201@wolfmountaingroup.com>  <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com> 
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Nate Diller <nate.diller@gmail.com>, sds@tycho.nsa.gov, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching 
Date: Wed, 25 Oct 2006 18:21:16 +0100
Message-ID: <25083.1161796876@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:

> SELinux support addresses all of these issues for B1 level security quite
> well with mandatory access controls at the fs layers.  In fact, it works so
> well, when enabled you cannot even run apache on top of an FS unless
> configured properly.

How?  The problem I've got is that the caching code would be creating and
accessing files and directories with the wrong security context - that of the
calling process - and not a context suitable for sharing things in the cache
whilst protecting them from userspace as best we can.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
