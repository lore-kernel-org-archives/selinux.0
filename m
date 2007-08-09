Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79FmZ4W013033
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 11:48:35 -0400
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79FmYc5017626
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:48:34 GMT
Date: Thu, 9 Aug 2007 08:48:33 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
In-Reply-To: <20070807141415.525577324@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <313245.75436.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> This patchset adds the static/fallback labeling feature to NetLabel that has
> been requested on the SELinux mailing list more and more recently.  This new
> bit of functionality also matches what can be found on similar
> trusted/labeled
> OSs such as Trusted Solaris, HP-UX CMW, etc.  This patchset it not yet ready
> for "upstreaming" so please do not pull this into any tree bound for the
> mainline kernel; I still need to do more review and testing of the code.
> However, I know there are several of you on this list that have been
> anxiously
> awaiting this patchset so I thought I would make an early release so you
> could
> get a peek and test it out.  I won't be able to work on this patchset much,
> if
> at all, between August 10th and the 20th so don't expect an update from me
> until the end of August.
> 
> The basic idea is that currently there is no method for providing an external
> label to fallback on if a labeled networking mechanism such as NetLabel/CIPSO
> or labeled IPsec is not in use.  This patch adds a mechanism for providing a
> static fallback label, specified per interface/network, which is used when
> a NetLabel recognized labeling protocol (at this point CIPSO) is not in use.

I'm all in favor of the facility. I do however object to the use of
a secid as the mechanism for storing the default label. As I've mentioned
elsewhere, secid's are SELinux specific and add unnecessary overhead to
schemes that don't use them natively. I understand and appreciate that
SELinux is upstream, etc, etc. I understand that a scheme that does not
use secid's is less convenient for SELinux. Please?


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
