Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79JcxLD002849
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:38:59 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79JcvVe002621
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 19:38:57 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 15:38:27 -0400
Cc: selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com
References: <313245.75436.qm@web36614.mail.mud.yahoo.com>
In-Reply-To: <313245.75436.qm@web36614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708091538.27325.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[I'm moving offices today and am a bit behind on this thread right now so I'm 
cherry picking the easy threads]

On Thursday, August 9 2007 11:48:33 am Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > The basic idea is that currently there is no method for providing an
> > external label to fallback on if a labeled networking mechanism such as
> > NetLabel/CIPSO or labeled IPsec is not in use.  This patch adds a
> > mechanism for providing a static fallback label, specified per
> > interface/network, which is used when a NetLabel recognized labeling
> > protocol (at this point CIPSO) is not in use.
>
> I'm all in favor of the facility. I do however object to the use of
> a secid as the mechanism for storing the default label. As I've mentioned
> elsewhere, secid's are SELinux specific and add unnecessary overhead to
> schemes that don't use them natively. I understand and appreciate that
> SELinux is upstream, etc, etc. I understand that a scheme that does not
> use secid's is less convenient for SELinux. Please?

I was waiting for you to say something about this, and I think you'll be happy 
with my take on it ...

The patchset right now takes a binary/string blob label which it converts to a 
token/secid through the LSM secctx_to_secid interface and returns it to the 
LSM when it asks for the packet's security attributes.  If the LSM 
secctx_to_secid interface were to return an error value signifying that the 
running LSM did not implement that functionality it would be very easy to 
store the binary/string blob label and return that to the LSM when asked for 
security attributes.  However, like we talked about regarding the 
NetLabel/LSM domain mapping API work, until SMACK is accepted upstream I 
don't want to add any of these changes.

As long as the LSM hooks exist and the possibility of multiple LSM 
implementation exist I'm going to do my best to keep NetLabel LSM agnostic.  
If LSM were to go away and be replaced with SELinux (or some other LSM for 
that matter) then the NetLabel interface would change a bit to remove some of 
the abstraction.

That said, it may be a moot point as from what I've read so far this patchset 
doesn't appear to have much support.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
