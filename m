Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MDVvUF010429
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 09:31:57 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4MDVu61028506
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 13:31:56 GMT
Message-ID: <4652F0B7.60506@manicmethod.com>
Date: Tue, 22 May 2007 09:31:35 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: James Antill <jantill@redhat.com>, Paul Moore <paul.moore@hp.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com> <4651EFCC.1040500@redhat.com> <200705211543.10171.paul.moore@hp.com> <1179779222.23650.24.camel@code.and.org> <20070521221304.GB11544@w-m-p.com>
In-Reply-To: <20070521221304.GB11544@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Mon, May 21, 2007 at 04:27:02PM -0400, James Antill wrote
>   

> Would it make sense to make a distinction between end user modifiable
> types and admin types? For example, at first glance the following look as
> if they'd be most relevant for non-admin users:
>
>   
>>        HACK_TYPE("cvs_data_t", _("Read and write from CVS daemon"));
>>        HACK_TYPE("public_content_rw_t",
>>                  _("Read and write from CIFS/ftp/http/nfs/rsync"));
>>        HACK_TYPE("public_content_t", _("Read from CIFS/ftp/http/nfs/rsync"));
>>        HACK_TYPE("samba_share_t", _("Shared via CIFS (samba)"));
>>        HACK_TYPE("staff_home_t", _("Staff user data"));
>>        HACK_TYPE("staff_home_dir_t", _("Staff user home directory"));
>>        HACK_TYPE("sysadm_home_t", _("Sysadmin user data"));
>>        HACK_TYPE("sysadm_home_dir_t", _("Sysadmin user home directory"));
>>        HACK_TYPE("tmp_t", _("Temporary data"));
>>        HACK_TYPE("user_tmp_t", _("User temporary data"));
>>        HACK_TYPE("user_home_t", _("User data"));
>>        HACK_TYPE("user_home_dir_t", _("User home directory"));
>>        HACK_TYPE("xen_image_t", _("Xen image"));
>>     
>
> Maybe one way to do that would be to use a drop-down for the type that
> only contains the types that the user is actually permitted to change
> this object to?
>
>   

How would the client get that kind of information? apol is the only app 
I know if that does any kind of relabel analysis to see what who can 
relabel what-to-what and that would be a pretty high level dependency 
for nautilus (and it also uses the policy on disk instead of the one 
loaded into the kernel). Also the list would be completely unusable when 
run from unconfined_t, which is the normal use case.

> I think a good use case for either MCS or TE for normal users would be to
> mark untrusted Internet data (for example along with confining the web
> browser), and maybe separately mark sensitive data that should be
> inaccessible for most programs (financial records)?
>
> Hmmm, how about integrating MCS categories with the virtual desktop
> workspaces? For example, virtual desktop 2 is for the web browser, and
> virtual desktop 3 for GnuCash and related programs? The user (optionally)
> configures the category as part of the workspace properties, and apps
> launched on that workspace automatically use that category.
>
>   

sounds like you want CMW's for mcs and I doubt thats how people will 
want to use MCS (assuming they ever want to use it at all)

> I think the advantage of MCS would be that it's largely orthogonal to TE
> and could be customized according to local requirements without having
> the developers need to predict all the potential use cases.
>
>   

We have yet to determine if MCS is useful at all but I don't think that 
there are any doubts that TE is better for a huge number of security 
objectives, particularly things like allowing apache to read files in 
your home directory and things of that nature.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
