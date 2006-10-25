From: David Howells <dhowells@redhat.com>
In-Reply-To: <453FA220.3090001@wolfmountaingroup.com> 
References: <453FA220.3090001@wolfmountaingroup.com>  <453F9555.1050201@wolfmountaingroup.com> <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com> <25083.1161796876@redhat.com> 
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Nate Diller <nate.diller@gmail.com>, sds@tycho.nsa.gov, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching 
Date: Wed, 25 Oct 2006 19:15:58 +0100
Message-ID: <25891.1161800158@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:

> Have it access them as 0.0 (root) when you change the fsuid, etc. and I think
> this would satisfy security concerns.

That's what I'm currently doing, but Christoph objected and said I'm not
allowed to change fsuid and fsgid.

That also doesn't cover the MAC issues.

> I agree that it sounds like someone needs to instrument MAC layers with this
> subsystem.

Yes.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
