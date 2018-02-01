Message-ID: <1517496630.1750.20.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ben Kane <bbk1524@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 01 Feb 2018 09:50:30 -0500
In-Reply-To: <1517495654.1750.13.camel@tycho.nsa.gov>
References: <CAC7z9xBeQ7B5D-VG_RruwxAwWyChCghrvBuOaGc-YNsyrx4b_g@mail.gmail.com>
 <1517495654.1750.13.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Update setenforce, getenforce, sestatus man pages with
 references to each other.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-02-01 at 09:34 -0500, Stephen Smalley wrote:
> On Mon, 2018-01-29 at 11:27 -0600, Ben Kane wrote:
> > Hello,
> > 
> > Last week I was studying for the RHCSE certification, and I
> > couldn't
> > find how
> > to change SELinux's status from enforcing to permissive in the man
> > pages. This
> > patch updates the relevant man pages.
> > 
> > - Switching emails
> > 
> > I emailed Daniel Walsh, the man page author, and he connected me to
> > Petr
> > Lautrbach, who sent me to this mailing list (via my work email).
> > The
> > maintainer, Stephen Smalley, said I should remove my company's
> > legal
> > blurb at
> > the end of the email, and the email folks at my work (Acxiom Corp),
> > said it
> > would be better to use my personal email anyway.
> > 
> > - Patch format
> > 
> > I hope the patch is formatted correctly. I tried to follow the
> > notes
> > on the
> > wiki (
> > https://github.com/SELinuxProject/selinux/wiki/Contributing#contrib
> > ut
> > ing-code )
> > and I used a StackOverflow link ( https://stackoverflow.com/a/34184
> > 99
> > /2958070 )
> > to generate the patchfile.
> 
> These days people generally create patches by committing the change
> to
> their locally cloned repository via git commit, then producing a
> patch
> via git format-patch and emailing the result or directly sending it
> via
> git send-email.  Inline patches are preferred over attachments since
> that eases reading and commenting. See:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.htm
> l
> for guidance for Linux kernel patches; we generally follow the same
> approach although we aren't quite as strict.
> 
> Make sure you don't include anything above the first --- that you
> don't
> want included in the commit message with your patch, e.g. much of
> your
> content above isn't about the patch itself but rather asides that
> don't
> really belong in the final log message.
> 
> One question I have is why cross-reference getenforce/setenforce from
> the sestatus man page but not from the selinux man page.  If you were
> starting from no SELinux knowledge, how would you have found the
> sestatus man page in the first place?

BTW, the minimal fixes to apply this patch would include:
- Fix the patch description (remove anything not describing the change
itself, move any editorial notes after the first ---).
- Add a Signed-off-by: line signifying that you are contributing the
patch under the license associated with the upstream project; normally
this is generated for you when you run git commit -a -s and then
included in the output of git format-patch or git send-email.
