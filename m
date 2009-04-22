Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MFfm4x021405
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 11:41:48 -0400
Received: from mail-ew0-f177.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3MFfl5h017788
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 15:41:47 GMT
Received: by ewy25 with SMTP id 25so42380ewy.18
        for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 08:41:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
Date: Wed, 22 Apr 2009 10:41:44 -0500
Message-ID: <cadfc0e40904220841u6d305caj233f0bbfee09ea2b@mail.gmail.com>
Subject: Re: labeled network aware kernel
From: Xavier Toth <txtoth@gmail.com>
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 22, 2009 at 6:26 AM, Mark Webb <elihusmails@gmail.com> wrote:
> I am interested in experimenting with the labeled networking that SE
> Linux offers.  I am reading through Josh Brindle's blog
>
> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
>
> My question is, how do I know if my kernel is capable of supporting
> this?  I am currently running Fedora 10 with all the latest updates
> but not sure how to check.
>
> Also if I compile a kernel from source, is there anything that needs
> to be done in the configuring of the kernel build to enable the
> labeled networking?
>
> Thanks,
> Mark
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

netlabel is in the kernel and you'll need to use netlabeltcl from
netlabel_tools to configure it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
