Message-ID: <1515517010.5234.4.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Vit Mojzis <vmojzis@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Date: Tue, 09 Jan 2018 16:56:50 +0000
In-Reply-To: <1515510708.24762.10.camel@tycho.nsa.gov>
References: <2f76cc8e-b5a5-024e-2c60-baff93fa0bb9@redhat.com>
 <1515510708.24762.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: selabel_lookup() with MEDIA backend issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2018-01-09 at 10:11 -0500, Stephen Smalley wrote:
> On Mon, 2018-01-08 at 16:10 +0100, Vit Mojzis wrote:
> > Hi all,
> > there seems to be a discrepancy between man page and actual
> > behavior
> > of 
> > selabel_lookup() with MEDIA backend.
> > selabel_media man page says:
> >      "Should there not be a valid entry in the media file, then
> > the 
> > default removable_context file will be read (see
> > removable_context(5))."
> > 
> > but the removable_context file is never used (for more details and
> > a 
> > reproducer see https://bugzilla.redhat.com/show_bug.cgi?id=1395621)
> > .
> > 
> > I can see two possible solutions:
> >    1) Remove the removable_context file and adjust man pages
> > accordingly.
> > 
> >    2) (Probably better) Add mechanism for using the
> > removable_context
> > 
> > Which one would you prefer?
> > 
> > In case of the latter, would adding the content of
> > removable_context 
> > file to saved_data->spec_arr[nspec + 1] (label_media.c) and
> > returning
> > it 
> > in case lookup fails be a reasonable solution?
> > 
> > Thank you.
> 
> It appears that selinux_removable_context_path() and the
> removable_context configuration were added by Dan Walsh in 2004 for
> use
> by an external caller.  The selabel_media backend wasn't introduced
> until 2007, and has never called selinux_removable_context_path()
> AFAICT.  The man page reference to removable_context in
> selabel_media.5
> was added by Richard Haines in 2011.  I think the man page is just
> wrong.  I don't know if there are any users of
> selinux_removable_context_path() still but we can't remove it without
> breaking ABI.
> 

As I screwed up the man page I'll fix, however would you prefer option
2 where it will check the removable_context file as I'm happy to do
that instead.
