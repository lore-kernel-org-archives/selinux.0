From: Steve Grubb <sgrubb@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: type bounds audit messages
Date: Tue, 16 Jun 2009 11:23:52 -0400
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
References: <1244730288.10762.120.camel@localhost.localdomain> <200906161040.52279.sgrubb@redhat.com> <1245164133.2848.12.camel@localhost.localdomain>
In-Reply-To: <1245164133.2848.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906161123.52932.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 16 June 2009 10:55:33 am Eric Paris wrote:
> > > I feel good for all but the { setattr write }
> > >
> > > It's a new message, we have no parsers which need the old format, how
> > > would others feel about
> > >
> > > perm="setattr,write"   ?
> >
> > I'd recommend losing the quotes. I think you are doing this because of
> > untrusted_string, but I doubt the user can influence this.
>
> I'm starting to buy into the 'quotes makes it easy to know it's a
> string' argument from jdennis.

Any field that has a value starting and ending with quotes means that its 
encoded due to untrusted users having influence over it. That is the parsing 
rule.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
