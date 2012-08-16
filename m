MIME-Version: 1.0
In-Reply-To: <1345142166.4222.4.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdoTt=7Q0iTr4yRKYuTD3w0PsJhzhTDSwcb50S7q+O3F7w@mail.gmail.com>
	<1345142166.4222.4.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 16 Aug 2012 11:56:24 -0700
Message-ID: <CAFftDdpX7oysYKgMOCxQ5Oneaf6-U9K95hfbbuWZpcOU-3yK1A@mail.gmail.com>
Subject: Re: overriding booleans
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yeah that was my second approach..

On Thu, Aug 16, 2012 at 11:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2012-08-16 at 11:34 -0700, William Roberts wrote:
>> Is their a way to override the default value of a boolean in another
>> te file in device?
>
> No, but you can just set the desired default in your init.<board>.rc
> file using the setsebool built-in command.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
