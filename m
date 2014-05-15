From: Paul Moore <pmoore@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH] selinux: prevent setting a security label on
 MNT_NOSUID applications
Date: Thu, 15 May 2014 11:14:19 -0400
Message-ID: <3937310.71HJKD7fOT@sifl>
In-Reply-To: <CALCETrW9WNVQoRFxy+T5Gs9Ct+1L-_bycTukWQdEgDgkZQKh1g@mail.gmail.com>
References: <20140514155807.32072.32113.stgit@localhost>
 <1904410.NyD4ciNI6n@sifl>
 <CALCETrW9WNVQoRFxy+T5Gs9Ct+1L-_bycTukWQdEgDgkZQKh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, May 14, 2014 02:26:59 PM Andy Lutomirski wrote:
> On Wed, May 14, 2014 at 2:00 PM, Paul Moore <pmoore@redhat.com> wrote:
> > On Wednesday, May 14, 2014 09:18:35 AM Andy Lutomirski wrote:
> >> > On Wed, May 14, 2014 at 8:58 AM, Paul Moore <pmoore@redhat.com> wrote:
> >> >> We presently prevent processes from explicitly setting an arbitrary
> >> >> security label on new processes when NO_NEW_PRIVS is enabled; in an
> >> >> attempt for more consistency, this patch extends this to prevent
> >> >> setting an arbitrary label when the new application lives on a
> >> >> filesystem mounted with MNT_NOSUID.
> >> >> 
> >> >> Signed-off-by: Paul Moore <pmoore@redhat.com>
> >> >> CC: Andy Lutomirski <luto@amacapital.net>
> >> >> CC: Stephen Smalley <sds@tycho.nsa.gov>
> >> >> ---
> >> 
> >> Acked-by: Andy Lutomirski <luto@amacapital.net>
> >> 
> >> I'm also unconvinced by the subject line -- would "selinux: return an
> >> error when rejecting settexeccon on MNT_NOSUID applications" be
> >> better?
> > 
> > ...
> > 
> > On Wednesday, May 14, 2014 12:28:24 PM Stephen Smalley wrote:
> >> On 05/14/2014 11:58 AM, Paul Moore wrote:
> >> > We presently prevent processes from explicitly setting an arbitrary
> >> > security label on new processes when NO_NEW_PRIVS is enabled; in an
> >> > attempt for more consistency, this patch extends this to prevent
> >> > setting an arbitrary label when the new application lives on a
> >> > filesystem mounted with MNT_NOSUID.
> >> 
> >> It is never arbitrary (the new value is always controlled by policy),
> >> and it isn't set on "new processes" per se but rather transitioned to
> >> upon an exec.  Anyway, the point of the change is to return an error
> >> rather than silently ignore any /proc/self/attr/exec value when
> >> executing from a nosuid mount.
> >> 
> >> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > I had a feeling while writing the patch description yesterday that someone
> > was not going to be happy with the text ... does the subject/description
> > below sound better to you guys?
> > 
> > ***
> > selinux: reject setexeccon() on MNT_NOSUID applications with -EACCES
> > 
> > We presently prevent processes from using setexecon() to set the security
> > label of exec()'d processes when NO_NEW_PRIVS is enabled by returning an
> > error; however, we silently ignore setexeccon() when exec()'ing from a
> > nosuid mounted filesystem.  This patch makes things a bit more consistent
> > by returning an error in the setexeccon()/nosuid case.
> > ***
> 
> Looks good to me.

Okay, I expect if Stephen had a strong objection to the new text he would have 
commented by now.  I'm going to toss this into #next with the new text now.

-- 
paul moore
security and virtualization @ redhat
