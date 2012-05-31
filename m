Subject: Re: Update patches for hci_attach service in SE Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <CAFftDdrW0+3Fqbr0Anm6rKxqcE6LhHDa3qd_NG11bskf95Orog@mail.gmail.com>
References: 
	 <CAFftDdrW0+3Fqbr0Anm6rKxqcE6LhHDa3qd_NG11bskf95Orog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 May 2012 09:47:36 -0400
Message-ID: <1338472056.11009.32.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-05-24 at 16:47 -0700, William Roberts wrote:
> The previous set up patches submitted yesterday got a reworking today
> with the help of Stephen (Thanks).
> 
> 
> Here are the most recent changes:
> 1. external/sepolicy/hci_attach.te is created. Since all Android
> devices have a hci_attach service, the rules can be allowed in there.
> 2. device/samsung/tuna policy.fc Labels the files properly that
> represent the hci_attach service. This varies per device.
> 3. General clean up

Thanks, merged.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
