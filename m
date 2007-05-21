Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LMDO4C027474
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 18:13:24 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LMDMd9013857
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 22:13:23 GMT
Date: Mon, 21 May 2007 17:13:04 -0500
From: Klaus Weidner <klaus@atsec.com>
To: James Antill <jantill@redhat.com>
Cc: Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
Message-ID: <20070521221304.GB11544@w-m-p.com>
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com> <4651EFCC.1040500@redhat.com> <200705211543.10171.paul.moore@hp.com> <1179779222.23650.24.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179779222.23650.24.camel@code.and.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 21, 2007 at 04:27:02PM -0400, James Antill wrote:
> On Mon, 2007-05-21 at 15:43 -0400, Paul Moore wrote:
> > If I recall correctly, there was some chatter about creating a more generic 
> > translation facility so that we could translate the entire SELinux context, 
> > versus the MLS range which we do now, into a more human readable label.  I 
> > believe doing something like this would help achieve some of the goals that 
> > Klaus hinted at with the "make it more suitable for everyday use by 
> > non-experts".  It would also help to reinforce the notion that the context is 
> > a blob and in general shouldn't be parsed by applications that don't know 
> > what they are doing.
> 
>  Right, this is one of the really horrible things in the nautilus code
> to change the context. I've included the full function at the end of
> this email, so you can all bask in it's unworthyness (and it's probably
> already out of date).
>  If we can fix this in a good way just for targeted/nautilus, that would
> be a significant win ... the other obvious use would be integration into
> sealert messages.

(Disclaimer: I haven't tried the current Nautilus, so apologies if this
is already implemented or if I've misunderstood things.)

The refpolicy already has nice self-documenting features, I think it
would be nice to use the same XML system for describing types and
attributes in a machine-readable way. Maybe also with both the
human-readable name and a longer descriptive text? Then the Nautilus
build could pick up the information automatically.

Would it make sense to make a distinction between end user modifiable
types and admin types? For example, at first glance the following look as
if they'd be most relevant for non-admin users:

>        HACK_TYPE("cvs_data_t", _("Read and write from CVS daemon"));
>        HACK_TYPE("public_content_rw_t",
>                  _("Read and write from CIFS/ftp/http/nfs/rsync"));
>        HACK_TYPE("public_content_t", _("Read from CIFS/ftp/http/nfs/rsync"));
>        HACK_TYPE("samba_share_t", _("Shared via CIFS (samba)"));
>        HACK_TYPE("staff_home_t", _("Staff user data"));
>        HACK_TYPE("staff_home_dir_t", _("Staff user home directory"));
>        HACK_TYPE("sysadm_home_t", _("Sysadmin user data"));
>        HACK_TYPE("sysadm_home_dir_t", _("Sysadmin user home directory"));
>        HACK_TYPE("tmp_t", _("Temporary data"));
>        HACK_TYPE("user_tmp_t", _("User temporary data"));
>        HACK_TYPE("user_home_t", _("User data"));
>        HACK_TYPE("user_home_dir_t", _("User home directory"));
>        HACK_TYPE("xen_image_t", _("Xen image"));

Maybe one way to do that would be to use a drop-down for the type that
only contains the types that the user is actually permitted to change
this object to?

I think a good use case for either MCS or TE for normal users would be to
mark untrusted Internet data (for example along with confining the web
browser), and maybe separately mark sensitive data that should be
inaccessible for most programs (financial records)?

Hmmm, how about integrating MCS categories with the virtual desktop
workspaces? For example, virtual desktop 2 is for the web browser, and
virtual desktop 3 for GnuCash and related programs? The user (optionally)
configures the category as part of the workspace properties, and apps
launched on that workspace automatically use that category.

I think the advantage of MCS would be that it's largely orthogonal to TE
and could be customized according to local requirements without having
the developers need to predict all the potential use cases.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
