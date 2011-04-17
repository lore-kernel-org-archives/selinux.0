Message-ID: <4DAA4F49.5050103@manicmethod.com>
Date: Sat, 16 Apr 2011 22:24:09 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>, Eric Paris <eparis@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: revise /selinux/create to handle whitespace/multibytes
 correctly
References: <BANLkTi=Czi-Zh1s3YP+rG4KZr1uwoHUTXA@mail.gmail.com>	<4DA9C73D.1000403@manicmethod.com> <BANLkTi=ogbDZ8qjPNroumu=mbU2A6hU0XQ@mail.gmail.com>
In-Reply-To: <BANLkTi=ogbDZ8qjPNroumu=mbU2A6hU0XQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei KaiGai wrote:
> 2011/4/16 Joshua Brindle<method@manicmethod.com>:
>> Kohei KaiGai wrote:
>>> This patch allows to accept percent-encoded object name as the forth
>>> argument of /selinux/create interface to avoid possible bugs when we
>>> supply an object name that includes whitespace or multibytes.
>> Why not use standard bash escaping instead of html entities?
>>
> Does bash has a way to escape multibyte characters safety?
>
> Here are various number of multibyte encoding systems rather than unicode.
> For example, Japanese has three major encoding; EUC, JIS and Shift-JIS.
> If we try to use the code 0x5c ('\') as escape sequence, we may have
> possible trouble on the Shift-JIS environment, because it contains several
> characters that use 0x5c as second character.
>
> The bad news is Shift-JIS was the default encoding system delivered from
> MS-DOS, so it is still popular on Linux systems migrated from legacy ones. :-(
>
> Of course, we have many language support, I don't know what side effects
> may happen on a particular environment.
>
> So, it seems to me the assumption of percentage-encoding is enough
> conservative to deliver an object name from userspace to kernel.
>

Actually, this all seems moot since the current userspace labeling 
doesn't handle multibyte encoding.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
