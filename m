Subject: Re: [patch] libsemanage:  do not hard link files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <C69F4B0E.A963B%csellers@tresys.com>
References: <C69F4B0E.A963B%csellers@tresys.com>
Content-Type: text/plain
Date: Wed, 05 Aug 2009 14:51:11 -0400
Message-Id: <1249498271.5213.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-05 at 14:43 -0400, Chad Sellers wrote:
> On 8/5/09 11:19 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> > Remove the support for hard linking files in semanage_copy_file, as it
> > is unsafe and can leave the active store corrupted if something goes
> > wrong during the transaction.  It also can leave the installed policy
> > files with incorrect file modes or security contexts.
> > 
> > To do this safely, we would need to change all functions that write to
> > the sandbox files to first unlink the destination file.  This was done
> > in the original patch for the write_file helper but not for other cases.
> > It would need to be done for all functions that open.*O_CREAT or
> > fopen.*w on a file in the sandbox.
> > 
> > We also don't want this applied to the installed policy files, as they
> > need to be created with appropriate file modes and security contexts
> > that may differ from the sandbox files.  At present, the hard link
> > support will only affect the installed policy files when they are first
> > created; afterward the link() call will always fail with EEXIST since
> > they are not unlinked prior to installation (nor would that be safe as
> > it could leave the system without a policy - rename would make more
> > sense in that situation).  If we were to re-introduce hard link support,
> > we ought to use different helpers or flags for installing the policy
> > files than for copying the active store to the temporary sandbox to
> > avoid affecting both.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index 855226a..d563841 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -559,8 +559,6 @@ static int write_file(semanage_handle_t * sh,
> >  {
> > int out;
> >  
> > - /* Unlink no matter what, incase this file is a hard link, ignore error */
> > - unlink(filename);
> > if ((out =
> >     open(filename, O_WRONLY | O_CREAT | O_TRUNC,
> >  S_IRUSR | S_IWUSR)) == -1) {
> 
> Why remove the unlink() call here? Isn't it safer to leave this. Otherwise,
> if the file was previously a hard link (say because the user was using a
> version of libsemanage before your patch), we'll break things. Or am I
> missing something?

The write_file helper only gets used to write to (some) files in the
temporary sandbox, which gets re-created on each transaction.  There
won't be any residual hard links left around between transactions that
would be affected.

> Other than that I like the idea of removing the brokenness by always making
> a copy.
> 
> Thanks,
> Chad
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
