Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1L3o1lU024881
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 22:50:01 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1L3pJFm008433
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 03:51:19 GMT
Received: by an-out-0708.google.com with SMTP id d33so525422and
        for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 19:51:19 -0800 (PST)
Message-ID: <e739902b0702201951p813ad71vefb0dd0069448a07@mail.gmail.com>
Date: Tue, 20 Feb 2007 19:51:12 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Is the usercanread attribute still needed?
In-Reply-To: <e739902b0702201944t104d6915raff5949c8e579885@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
	 <1172004294.20576.236.camel@sgc.columbia.tresys.com>
	 <e739902b0702201944t104d6915raff5949c8e579885@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry all,

I forgot to include the SELinux mailing list.

Thanks,

- Ryan

On 2/20/07, Ryan Bradetich <rbradetich@gmail.com> wrote:
> Hello Chris,
>
> Thanks much for your reply!
> I have attached an updated patch that leaves the attribute definition
> in the files.te file.
>
> Just out of curiosity, what is the policy for obsoleting these attributes?
> At next policy file rev?
>
> Thanks!
>
> - Ryan
>
>
> On 2/20/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > Since modules are statically compiled, we can't completely remove the
> > attribute yet, otherwise it might cause some policies to fail to link if
> > it is still required.  However, the typeattribute could be removed from
> > files_config_file().
> >
> > --
> > Chris PeBenito
> > Tresys Technology, LLC
> > (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
