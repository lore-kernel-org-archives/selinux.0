Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9EF4Jwg030803
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 11:04:19 -0400
Received: from mail-gx0-f10.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9EF3215022440
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 15:03:02 GMT
Received: by gxk3 with SMTP id 3so5208445gxk.18
        for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 08:04:19 -0700 (PDT)
Message-ID: <dd18b0c30810140804h6ceed751ke3f5cc43f0b9a2e3@mail.gmail.com>
Date: Tue, 14 Oct 2008 08:04:18 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [refpolicy] newrole without even knowing
Cc: "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <48F48E51.7080109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30810131504h67a496e7h2247b3bf487d04ec@mail.gmail.com>
	 <48F48E51.7080109@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 14, 2008 at 5:19 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Justin Mattock wrote:
>> Hello; is there an application that I can use for
>> newrole, so I dont have to open a terminal?
>> i.g. running firefox I have to open a terminal
>> type newrole -r *_r  <passwd> and then firefox
>> to run. Idealistically I would like to just click on any icon
>> and have them already configured with its role.
>> I've tried in the menu configuration newrole -r *_r && firefox
>> but I receive nothing.
>> Any ideas would be appreciated.
>> regards;
>>
> runcon?  Or write policy to transition automatically.  You can also do
> stuff with sudo.
>

Cool, thanks for giving me the info
on how to do that. Having the policy transition automatically
sounds nice, its just a matter of knowing what to write and where.
>From what it looks like, I'm going to probably have to do some research
before attempting something like that.
Anyways as long as it's possible to have such a thing.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
