Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3SDMNlD005194
 for <selinux@tycho.nsa.gov>; Fri, 28 Apr 2017 09:22:23 -0400
Message-ID: <1493385737.4123.1.camel@btinternet.com>
Subject: Re: [PATCH V2] libselinux: Add permissive= entry to avc audit log
From: Richard Haines <richard_c_haines@btinternet.com>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 28 Apr 2017 14:22:17 +0100
In-Reply-To: <20170428131021.GA13764@julius>
References: <20170428130516.4021-1-richard_c_haines@btinternet.com>
 <20170428131021.GA13764@julius>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-28 at 15:10 +0200, Dominick Grift wrote:
> On Fri, Apr 28, 2017 at 02:05:16PM +0100, Richard Haines wrote:
> > Add audit log entry to specify whether the decision was made in
> > permissive mode/permissive domain or enforcing mode.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 changes: Remove utilities and follow the kernel way of detecting
> > whether permissive or not.
> > 
> >  libselinux/src/avc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index b1ec57f..96b2678 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -723,6 +723,10 @@ void avc_audit(security_id_t ssid,
> > security_id_t tsid,
> >  
> >  	log_append(avc_audit_buf, " ");
> >  	avc_dump_query(ssid, tsid, tclass);
> > +
> > +	if (denied)
> > +		log_append(avc_audit_buf, " permissive=%u", result
> > ? 0 : 1);
> > +
> >  	log_append(avc_audit_buf, "\n");
> >  	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> >  
> > -- 
> > 2.9.3
> > 
> 
> I hope you will still submit the utils as well. I think/hope that the
> selinux_check_access util can be used with shell scripts to create a
> simple user space object manager example

Yes I will at some stage - just thinking of how to reply to Stephen's
email on the subject and checking what ones I've already submitted to
libselinux/utils. I have a number of these little
utils/samples/examples that I use to test various bits of
libsepol/libselinux and submit those I use to test my patches.

Before I submit any I'll take your suggestion into acount. All ideas
welcome.
> 
