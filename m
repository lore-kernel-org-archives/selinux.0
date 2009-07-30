Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6U5FDEN018505
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 01:15:13 -0400
Received: from rv-out-0708.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6U5ElX3015607
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 05:14:47 GMT
Received: by rv-out-0708.google.com with SMTP id c5so314366rvf.54
        for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2009 22:15:11 -0700 (PDT)
Subject: Re: is it safe to use ext4 for SELinux
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Christopher Pardy <cpardy@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A711BA7.6010308@redhat.com>
References: <4A7083DB.4000003@gmail.com> <4A70894E.7000701@redhat.com>
	 <4A708F41.2070902@gmail.com>  <4A711BA7.6010308@redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 22:14:55 -0700
Message-Id: <1248930895.3374.8.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 00:03 -0400, Daniel J Walsh wrote:
> On 07/29/2009 02:04 PM, Justin P. Mattock wrote:
> > Christopher Pardy wrote:
> >> On 07/29/2009 01:16 PM, Justin P. Mattock wrote:
> >>   
> >>> I've just downloaded the fedora 11 livecd and am installing it on an
> >>> imac. during the partition scheme should I use ext4,
> >>> or stick with ext3 for SELinux to function properly?
> >>>
> >>> Justin P. Mattock
> >>>
> >>> -- 
> >>> This message was distributed to subscribers of the selinux mailing list.
> >>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> >>> with
> >>> the words "unsubscribe selinux" without quotes as the message.
> >>>      
> >>
> >> OMG wrong list!!!! send fedora related stuff to fedora-selinux please!
> >> Also.... No, use ext4.
> >>
> >>    
> > 
> > I'll have to search for the lists to join.
> > in the meantime it is possible to have
> > SELinux on ext4
> >
> Yes SELinux should work on any file system that supports extended attributes.
>  
> > Justin P. Mattock
> > 
> > -- 
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with
> > the words "unsubscribe selinux" without quotes as the message.
> 

I must admit that I'm out of the loop with new stuff.
(thought ext4 was not yet ready for SELinux).

Side note: fedora sure does run nice with SELinux
you can't even tell the policy/SELinux is turned on.
(I think I'm going to convert).

Thanks for the response on this, and
it is true about learning something new everyday!!

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
