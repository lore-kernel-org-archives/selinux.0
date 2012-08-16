Message-ID: <1345142166.4222.4.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: overriding booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 16 Aug 2012 14:36:06 -0400
In-Reply-To: <CAFftDdoTt=7Q0iTr4yRKYuTD3w0PsJhzhTDSwcb50S7q+O3F7w@mail.gmail.com>
References: 
	<CAFftDdoTt=7Q0iTr4yRKYuTD3w0PsJhzhTDSwcb50S7q+O3F7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-16 at 11:34 -0700, William Roberts wrote:
> Is their a way to override the default value of a boolean in another
> te file in device?

No, but you can just set the desired default in your init.<board>.rc
file using the setsebool built-in command.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
