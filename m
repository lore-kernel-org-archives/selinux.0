Subject: Re: Update patches for hci_attach service in SE Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <CAFftDdoNQ0NE=Ha4LqK5XH4jutTkX8FYSPMA9YfYCqxi3WSTFw@mail.gmail.com>
References: 
	 <CAFftDdrW0+3Fqbr0Anm6rKxqcE6LhHDa3qd_NG11bskf95Orog@mail.gmail.com>
	 <CAFftDdoNQ0NE=Ha4LqK5XH4jutTkX8FYSPMA9YfYCqxi3WSTFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 May 2012 15:16:36 -0400
Message-ID: <1338318996.17627.162.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, still catching up...

On Tue, 2012-05-29 at 15:13 -0400, William Roberts wrote:
> Is anyone reviewing these patches for submission into mainline? 
> 
> On Thu, May 24, 2012 at 7:47 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>         The previous set up patches submitted yesterday got a
>         reworking today with the help of Stephen (Thanks).
>         
>         
>         Here are the most recent changes:
>         1. external/sepolicy/hci_attach.te is created. Since all
>         Android devices have a hci_attach service, the rules can be
>         allowed in there.
>         2. device/samsung/tuna policy.fc Labels the files properly
>         that represent the hci_attach service. This varies per device.
>         3. General clean up
>         
>         
>         -- 
>         Respectfully,
>         
>         William C Roberts
>         
>         
>         
> 
> 
> 
> 
> -- 
> Respectfully,
> 
> William C Roberts
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
