From: "Roberts, William C" <william.c.roberts@intel.com>
To: Paul Moore <paul@paul-moore.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>, "Stephen
 Smalley" <sds@tycho.nsa.gov>
Subject: RE: [PATCH 1/3] selinux: detect invalid ebitmap
Date: Mon, 29 Aug 2016 23:26:06 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560128BD81@ORSMSX103.amr.corp.intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhSJ58N=f_jJO3Q3TY7JKViT4RS3N2Ly4iHVBj3pTHHxXw@mail.gmail.com>
In-Reply-To: <CAHC9VhSJ58N=f_jJO3Q3TY7JKViT4RS3N2Ly4iHVBj3pTHHxXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Paul Moore [mailto:paul@paul-moore.com]
> Sent: Monday, August 29, 2016 4:21 PM
> To: Roberts, William C <william.c.roberts@intel.com>
> Cc: selinux@tycho.nsa.gov; seandroid-list@tycho.nsa.gov; Stephen Smalley
> <sds@tycho.nsa.gov>
> Subject: Re: [PATCH 1/3] selinux: detect invalid ebitmap
> 
> On Tue, Aug 23, 2016 at 4:49 PM,  <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > When count is 0 and the highbit is not zero, the ebitmap is not valid
> > and the internal node is not allocated. This causes issues when
> > routines, like mls_context_isvalid() attempt to use the
> > ebitmap_for_each_bit() and ebitmap_node_get_bit() as they assume a
> > highbit > 0 will have a node allocated.
> > ---
> >  security/selinux/ss/ebitmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Hi William,
> 
> This patch looks good to me, but do I have your permission to add your sign-off?

Yes, I guess I missed it. Just so it's easy for you to copy paste:
Signed-off-by: William Roberts <william.c.roberts@intel.com>


> 
> > diff --git a/security/selinux/ss/ebitmap.c
> > b/security/selinux/ss/ebitmap.c index 894b6cd..7d10e5d 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -374,6 +374,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >                 goto ok;
> >         }
> >
> > +       if (e->highbit && !count)
> > +               goto bad;
> > +
> >         for (i = 0; i < count; i++) {
> >                 rc = next_entry(&startbit, fp, sizeof(u32));
> >                 if (rc < 0) {
> > --
> > 1.9.1
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> 
> --
> paul moore
> www.paul-moore.com
