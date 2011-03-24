Subject: Re: SELinux: avc_has_perm: unexpected error 22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <4D8AACD9.60505@gmail.com>
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>
	 <4D8AACD9.60505@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Mar 2011 09:58:57 -0400
Message-ID: <1300975137.8157.38.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-03-23 at 19:30 -0700, Justin P. Mattock wrote:
> On 03/23/2011 11:07 AM, Justin P. Mattock wrote:
> > On 03/21/2011 09:52 AM, Justin P. Mattock wrote:
> >> this is showing up with the latest Mainline kernel.
> >> gdm craps out..:
> >>
> >> [ 60.817] (II) Unloading synaptics
> >> [ 60.822] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.822] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.828] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.831] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.871] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.871] SELinux: avc_has_perm: unexpected error 22
> >> [ 60.881] (II) UnloadModule: "mouse"
> >> [ 60.881] (II) Unloading mouse
> >>
> >>
> >> full xorg.0.log is here:
> >> http://fpaste.org/OOM2/
> >>
> >> Justin P. Mattock
> >
> > seems doing a bisect right now during the merge window is breaking,
> > anyways looking through the commits I think this:
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c53fa1ed92cd671a1dfb1e7569e9ab672612ddc6;hp=06dc94b1ed05f91e246315afeb1c652d6d0dc9ab
> >
> >
> > might be what I am hitting, causing gdm to die out, as it starts.
> >
> > any ideas?
> >
> > Justin P. Mattock
> 
> not sure if anybody is seeing this or hitting this with the current,
> but reverting the above commit does not fix the problem.
> will try another bisect(hopefully)

Are you sure it is a kernel issue?  Seems more likely that it would be a
policy problem.  What AVC denials are you getting?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
