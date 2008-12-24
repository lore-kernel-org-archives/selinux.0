Message-ID: <cadfc0e40812240823x5c10c135p59b229fad22c7fb3@mail.gmail.com>
Date: Wed, 24 Dec 2008 10:23:55 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
Cc: "Joe Nall" <joe@nall.com>, "SELinux List" <selinux@tycho.nsa.gov>,
        "James Carter" <jwcart2@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <494187BF.2090301@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4927839F.4070805@tycho.nsa.gov>
	 <AD1BDA2B-D7CF-48AC-846E-54DC795B3C08@nall.com>
	 <492AFFAD.5070805@tycho.nsa.gov>
	 <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com>
	 <494187BF.2090301@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 11, 2008 at 3:35 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Xavier Toth wrote:
>>
>> Sorry to be pedantic but is there a reference implementation or will
>> the mcstrans developer (Joe) have to develop it?
>>
>> Ted
>>
>
> Also here is a preliminary libselinux patch.
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>

This patch could be upstreamed now because even if the installed
mcstrand doesn't support color a call to selinux_raw_context_to_color
will simply retrun an error, right?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
