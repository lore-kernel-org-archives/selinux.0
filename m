Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CGkw9v001651
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 12:46:58 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5CGkv8g015334
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 16:46:57 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC] use the netmsg initial SID for NetLabel connections
Date: Tue, 12 Jun 2007 12:46:31 -0400
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
References: <20070607205808.935275285@hp.com> <200706080958.17891.paul.moore@hp.com> <1181650336.16029.47.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181650336.16029.47.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706121246.32008.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, June 12 2007 8:12:16 am Christopher J. PeBenito wrote:
> On Fri, 2007-06-08 at 09:58 -0400, Paul Moore wrote:
> > I still have a question about the best way to provide both labeled and
> > unlabeled NetLabel support to all of the user/application domains in the
> > policy.  I don't have a problem going through all the individual domains
> > and adding calls like these:
> >
> >   corenet_{tcp,udp,raw}_recv_unlabeled(<domain>)
> >   corenet_{tcp,udp,raw}_recv_netlabel(<domain>)
> >
> > ... but I was wondering if there was another way I should go about making
> > the change?
>
> No, that's the right method.  I've been thinking about if this is the
> right vocabulary for the interfaces; I'd like to make it workable for
> labeled ipsec too.

Yes, especially for the unlabeled case.  I would think having a single 
interface to allow a domain to receive unlabeled traffic would be much better 
than two.

> The problem is that ipsec is a little different, 
> where you might have interfaces like apache_tcp_recvfrom_user_script().

Yes, you also have all the SPD matching issues to deal with.  Hopefully later 
this year I'll have NetLabel supporting full SELinux contexts which should 
make NetLabel and IPsec very similar in regards to packet subject/object 
labels; the class/permissions will still be different but that is more of an 
interface implementation issue than an actual interface/API issue.

Thanks for you help, I'll hope to have a patch for you to review within a week 
or two that adds the corenet/NetLabel interfaces to the policy in SVN.  I'd 
like to get this accepted and merged before I push the final kernel patch up 
to James/Stephen as the kernel changes require a new/updated policy to work 
correctly.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
