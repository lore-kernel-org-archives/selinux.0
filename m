From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: av_decision on audit callback
Date: Fri, 2 Oct 2015 20:22:00 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560107F142@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC560107EEE9@ORSMSX103.amr.corp.intel.com>
 <560ED2EF.6090402@tycho.nsa.gov> <560ED713.5090004@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC560107F107@ORSMSX103.amr.corp.intel.com>
 <560EE55C.9090206@tycho.nsa.gov>
In-Reply-To: <560EE55C.9090206@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, October 2, 2015 1:13 PM
> To: Roberts, William C; seandroid-list@tycho.nsa.gov; selinux@tycho.nsa.gov
> Subject: Re: av_decision on audit callback
> 
> On 10/02/2015 04:07 PM, Roberts, William C wrote:
> >
> >
> >> -----Original Message-----
> >> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> >> Sent: Friday, October 2, 2015 12:12 PM
> >> To: Roberts, William C; seandroid-list@tycho.nsa.gov;
> >> selinux@tycho.nsa.gov
> >> Subject: Re: av_decision on audit callback
> >>
> >> On 10/02/2015 02:54 PM, Stephen Smalley wrote:
> >>> On 10/02/2015 02:48 PM, Roberts, William C wrote:
> >>>> I would like to be able to gather the result of permissive mode per
> >>>> domain from a check_access() call for the userspace object managers
> >>>> on Android.
> >>>>
> >>>>   From what I can tell check_access() calls avc_has_perm with a
> >>>> NULL 5th argument. That argument is for the struct avc_entry_ref.
> >>>>
> >>>> That structure has a pointer to an opaque type, avc_entry. Which
> >>>> contains struct av_decision.
> >>>>
> >>>> Which contains flags that have a permissive flag:
> >>>>
> >>>> struct av_decision {
> >>>>
> >>>>           access_vector_t allowed;
> >>>>
> >>>>           access_vector_t decided;
> >>>>
> >>>>           access_vector_t auditallow;
> >>>>
> >>>>           access_vector_t auditdeny;
> >>>>
> >>>>           unsigned int seqno;
> >>>>
> >>>>           unsigned int flags;
> >>>>
> >>>> };
> >>>>
> >>>> /* Definitions of av_decision.flags */
> >>>>
> >>>> #define SELINUX_AVD_FLAGS_PERMISSIVE    0x0001
> >>>>
> >>>> It looks like if check_access just passes this structure and then
> >>>> avc_has_perm() when it calls avc_audit, it could supply the
> >>>> av_decision structure to the avc_suppl_audit() call. We could then
> >>>> have an audit2 callback that takes this parameter.
> >>>>
> >>>> Is this mostly right, seem sane? Better way to do this?
> >>>
> >>> It doesn't need to be exposed at that level; the libselinux
> >>> avc_audit() routine can log it, similar to what is done in the kernel.
> >>> It already has the av_decision structure available to it.
> >>
> >> To clarify, anything directly known to the AVC, like the permissive
> >> flag, can be directly logged by it.  The audit callback is for
> >> logging auxiliary audit information not known to the AVC (the pid of the client
> process being a good example).
> >
> > I was wondering if we could just dump permissive=0|1 from the AVC
> > logging routine, but that would affect everyone.  I guess then you
> > would be ok with that? Does order matter with the fields wrt parsing?
> > I don't want to break any desktop tooling I am aware of, would we upstream
> this change as well?
> 
> Just put it at the end (i.e. log_append() after the avc_dump_query() call), like we
> do in the kernel.  Shouldn't be a problem.  Technically order shouldn't matter but
> safer to just append it to the current fields.
> 
> Yes, we'd upstream it.
> 
Done. Ill post back with a patch on android-review. And once merged there I can send one to the
Mailing list or you can cherry-pick. Are you ok with that?
