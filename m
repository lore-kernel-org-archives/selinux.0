Message-ID: <1518102162.21656.46.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Date: Thu, 08 Feb 2018 10:02:42 -0500
In-Reply-To: <CAHC9VhTt1GZeDuhacdMbF9J9q3xndqVO=k4UqQT6v_n_Cq3vrA@mail.gmail.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-2-sds@tycho.nsa.gov>
 <CAHC9VhTGF6_zP46tP3JdWna2_7BJ+oD0eKccmAhy3xXdfeRZ_w@mail.gmail.com>
 <1518025709.16883.48.camel@tycho.nsa.gov>
 <CAHC9VhTt1GZeDuhacdMbF9J9q3xndqVO=k4UqQT6v_n_Cq3vrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 01/10] selinux: introduce a selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-02-07 at 14:56 -0500, Paul Moore wrote:
> On Wed, Feb 7, 2018 at 12:48 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Tue, 2018-02-06 at 17:18 -0500, Paul Moore wrote:
> 
> ...
> 
> > > While I don't think we need to tackle this as part of the
> > > encapsulation work, this is another reminder that we should look
> > > into
> > > breaking the separation between the security server and the
> > > Linux/hooks code.  I understand there were historical reasons for
> > > this
> > > split, but I think all of those reasons are now gone, and further
> > > I
> > > think enough Linux'isms have crept into the security server that
> > > the
> > > separation is no longer as meaningful as it may have been in the
> > > past.
> > 
> > I think we want to retain some degree of encapsulation of the
> > policy
> > logic and data structures, which is what the security server is
> > supposed to provide.  That allows us to evolve that logic and
> > structures without impacting the object label management and
> > permission
> > enforcement code.  Separation of policy from mechanism.  I don't
> > mind
> > nativizing the security server for Linux, and where appropriate,
> > allowing some optimization of the interfaces between it and the
> > rest of
> > the SELinux code, but I wouldn't want to e.g. directly expose the
> > policydb to the rest of the code.  There has been some leakage of
> > policy awareness outside the security server in the past but I view
> > that as a mistake that ought to be corrected over time.
> 
> I agree that a level of abstraction between the policydb code and the
> enforcement code is a good thing, but I think there are some
> boundaries between the hook code and the security server that we
> could
> do without.  Once again, not really part of this work, just popped up
> in my head again while looking at these patches.

I wanted to clarify that point because it motivates keeping selinux_ss
as a separate struct from selinux_state (previously selinux_ns), and
not exposing the selinux_ss struct definition outside of the security
server.  So the selinux_state struct would still be something like:
struct selinux_state {
        bool disabled;
#ifdef CONFIG_SECURITY_SELINUX_DEVELOP
        bool enforcing;
#endif
        bool checkreqprot;
        bool initialized;
        bool policycap[__POLICYDB_CAPABILITY_MAX];
        struct selinux_avc *avc;
        struct selinux_ss *ss;
}

(dropping the reference count, work struct, and parent pointers that
were part of selinux_ns as being specific to the namespace work).

hooks.c would declare struct selinux_state selinux_state;.
ss/services.c would declare static struct selinux_ss selinux_ss; and
provide a selinux_ss_init() function (instead of selinux_ss_create)
that would set the ->ss field to &selinux_ss.  Likewise for avc.c and
the selinux_avc.  hooks.c:selinux_init() would call
selinux_ss_init(&selinux_state.ss) and
selinux_avc_init(&selinux_state.avc) to set those pointers to the
appropriate structures private to the ss and avc code.  The _create and
_free functions would go away and none of the structures would be
dynamically allocated/freed.

This is in contrast to exposing the selinux_ss struct definition
outside the security server and directly embedding it in the
selinux_state, since that would require exposing the policydb and
sidtab structures as well (unless we were to make those opaque pointers
within the selinux_ss; currently the policydb and sidtab are directly
embedded within it).  Likewise for the selinux_avc and its embedded
avc_cache structure.

Trying to make sure we're in agreement on the data structures before I
rewrite since I don't want to have to rewrite it twice ;)
