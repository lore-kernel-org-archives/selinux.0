MIME-Version: 1.0
In-Reply-To: <39957192-36AC-4A3E-A0D4-FDF353F202A6@nall.com>
References: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
	<3138EE6F-F894-46F2-A233-E3F014B1257C@nall.com>
	<CAFftDdqjHjjT2Ond9NHd7qkiYyFaEKYv3CZt2HxrPKsTQU-r8Q@mail.gmail.com>
	<39957192-36AC-4A3E-A0D4-FDF353F202A6@nall.com>
Date: Thu, 26 Jul 2012 18:30:27 -0700
Message-ID: <CAFftDdo4Atgqvnh1QTkrkvo5sJjpemXyYN4d9HtOanCwmKMuqQ@mail.gmail.com>
Subject: Re: Questions about the MLS to "read down"
From: William Roberts <bill.c.roberts@gmail.com>
To: Joe Nall <joe@nall.com>
Cc: Haiqing Jiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh ok thanks

On Thu, Jul 26, 2012 at 6:21 PM, Joe Nall <joe@nall.com> wrote:
>
> On Jul 26, 2012, at 8:15 PM, William Roberts <bill.c.roberts@gmail.com> wrote:
>
>> How did you determine that c42 doesn't dominate c16?
>
> Category dominance is having the same or a superset of the category bits. Using your category bits:
>
> s0:c16,c42 dominates s0:c16,c42, s0:c16, s0:c42 and s0
> s0:c42 dominates s0:c42 and s0
> s0:c16 dominates s0:c16 and s0
>
> joe



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
