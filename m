Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Windsor <dwindsor@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <CAEXv5_g+ookJ-TTWBXevNGSObQ2SUc-T3Bc9Tbz=6z070GiNEw@mail.gmail.com>
References: <4E7B9233.6080609@redhat.com>
	 <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>
	 <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>
	 <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>
	 <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
	 <1317139611.22218.9.camel@moss-pluto>
	 <CAEXv5_g+ookJ-TTWBXevNGSObQ2SUc-T3Bc9Tbz=6z070GiNEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Sep 2011 12:51:58 -0400
Message-ID: <1317142318.22218.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-27 at 12:50 -0400, David Windsor wrote:
> On Tue, Sep 27, 2011 at 12:06 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Sat, 2011-09-24 at 18:05 -0400, David Windsor wrote:
> >> On Fri, Sep 23, 2011 at 11:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> <snip>
> >>
> >> >>
> >> >>       level_default file fromsource; == MLS;
> >> >>       level_default file fromtarget; == MCS;
> >> >>
> >> >> Anyone want to step forward and implement?  :^)
> >> >
> >> > Need to distinguish low vs high.  In MLS, you want to inherit the low
> >> > level of the source/subject/process.
> >> >
> >> > Also, do you want the MCS behavior for all types or selectively?  For
> >> > example, if a svirt_t:s0:c256,c387 process creates a file in a :s0
> >> > directory (is that even possible?), do you really want that file to
> >> > be :s0?
> >> >
> >>
> >> Couldn't you use a range_transition in this case to specify an
> >> exception to the default behavior for category inheritance?
> >>
> >> AFAICS, using rules such as (user|role|type|level|range)_default,
> >> we're only specifying default labeling behaviors for the different
> >> fields of a context.  More specific *_transition rules can exist in
> >> policy that should override any defaults defined elsewhere.
> >
> > range_transition would only let you specify things like "When files are
> > created by a process with domain D in a directory with type T, the range
> > should be set to R.".  Not rules of the form "Files created by processes
> > in domain D1 should inherit their level from their creator while files
> > created by processes in domain D2 should inherit their level from the
> > parent directory."
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> 
> I realize that the semantics of the two rules are different.  I'm
> wondering about the precedence of *_default rules: given a policy in
> which conflicting labels are calculated for a newly created object of
> a certain type, do *_default rules take precedence?
> 
> For instance, suppose the following rules:
> 
> range_default D1_t file use_source;
> range_transition D1_t T_t:file R;
> 
> The first rule specifies that newly created files by processes in the
> D1_t domain should inherit the range of the source/creating process.
> The second rule specifies that files created by a process in the D1_t
> domain in a directory labeled T_t should have a range of R.  This
> seems to create a conflict for deciding the range of files created by
> processes labeled D1_t in a directory labeled T_t.
> 
> What should happen here?
> 
> I would think that the more specific range_transition rule, which
> specifies both the type of the creating process and the type of the
> parent directory, would dictate the labeling of the created file and
> that the range_default rule specifies labeling in the default case.

The *_default rules would just replace the current hardcoded default
logic.  They would be overridden by any matching *_transition rules just
as the current hardcoded default logic is overridden by such rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
