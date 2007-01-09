Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l094kCun020261
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 23:46:12 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l094l0mL016137
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 04:47:00 GMT
Date: Mon, 8 Jan 2007 22:43:25 -0600
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC 1/2] stricter MLS policy constraints
Message-ID: <20070109044325.GA24321@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com> <20061212073454.GA30421@w-m-p.com> <1168271261.12883.4.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168271261.12883.4.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 08, 2007 at 10:47:41AM -0500, Christopher J. PeBenito wrote:
> On Tue, 2006-12-12 at 01:34 -0600, Klaus Weidner wrote: 
> > Rename the "mlsfilewriteinrange" attribute with no functional changes.
> > The reason for the renaming is that this is an object attribute (like
> > "mlstrustedobject"), and it's confusing to use the naming scheme usually
> > used for subject attributes for it. It's currently only used for the
> > printer device object.
> > 
> > See 0/2 message for additional explanations.
> 
> Sorry for the late response, but its taken some time to clear out the
> backlog while I was out of the office.  This patch cannot be applied
> upstream because there is no compatibility for renaming the attribute.
> Since modules are statically compiled, anything that happens to use this
> attribute will fail to link.  The other patches seemed ok.
> 
> > -attribute mlsfilewriteinrange;
> > +attribute mlsrangedobject;

Is this really a big problem? If I remember correctly the attribute had
been introduced specifically to support the ranged printer device type
needed for Matt's labeled Cups extensions, and it's only used in a single
place in the shipped policy (which the patch updated). 

Of course I don't want to cause trouble for people using the refpolicy
with out-of-tree modules, is there a way to do the rename using an alias
interface or deprecation warning to give people time to switch? I think
it would be bad to be stuck with historically grown interfaces forever,
especially if the feature was just added recently.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
