Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NGAXGk018168
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 11:10:33 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NGBpPU000595
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 16:11:52 GMT
Subject: Re: Latest diffs - Resent with additional changes.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070221002727.GB9827@w-m-p.com>
References: <45B8ACBF.8090201@redhat.com>
	 <1171663101.20576.147.camel@sgc.columbia.tresys.com>
	 <20070219031951.GA9827@w-m-p.com> <45DB4F07.9040607@trustedcs.com>
	 <45DB79DB.3080209@trustedcs.com>  <20070221002727.GB9827@w-m-p.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 16:12:05 +0000
Message-Id: <1172247125.15371.48.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 18:27 -0600, Klaus Weidner wrote:
> On Tue, Feb 20, 2007 at 04:44:43PM -0600, Darrel Goeddel wrote:
> > Darrel Goeddel wrote:
> > The mlsrangedobject and mlswfilewriteinrange seem to be providing about
> > the same functionality (unless I'm missing something regarding the
> > comment above).  Why have a subject based override a few dir ops and an
> > object based override for most other file (in the general sense) ops?
> > I would think that these two constraint block should be identical, as
> > they used to be.  The only reason they were ever separated is due to
> > the fact that directories had operations other file classes did not
> > have.  Maybe have both overrides (subject and object) available and
> > make these two block match up?
> 
> The first patch I had sent renamed the existing "mlsfilewriteinrange"
> object based override to "mlsrangedobject" to match the naming
> conventions used for other object overrides, they are supposed to be the
> same thing. Apparently that patch was rejected upstream, which
> contributed to the confusion. They are supposed to be the same thing.

The only reason I had to reject renaming attributes is because it causes
a compatibility problem (the attribute you want to rename has been in a
refpolicy release).  In the (unlikely) case that a third party is
already using the interface that provides this attribute, their module
will break if you try to link it to a policy that has this change (if it
was compiled with the current interfaces).  This is all due to the fact
that interfaces modules are statically expanded, so mlsfilewriteinrange
will be required for their module.

Currently the only way that I can think of for renaming this but keeping
compatibility would be to:

1. add mlsrangedobject attribute
2. add the mlsconstraint expression for mlsrangedobject
3. add mls_ranged_object() interface
4. change mls_file_write_within_range() to call mls_ranged_object() and
throw a warning telling the user to use the mls_ranged_object()
interface using the refpolwarn() support macro

then after an appropriate transition time:

5. remove mlsfilewriteinrange attribute
6. remove mlsfilewriteinrange mlsconstraint expression
7. remove mls_file_write_within_range() interface

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
