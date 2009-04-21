MIME-Version: 1.0
In-Reply-To: <dd18b0c30904210713h74a3b6c1vadd4366aa3dbcbeb@mail.gmail.com>
References: <dd18b0c30904201610s5248e8e1w69f10aa7ad452911@mail.gmail.com>
	 <1240314838.1678.13.camel@localhost.localdomain>
	 <dd18b0c30904210713h74a3b6c1vadd4366aa3dbcbeb@mail.gmail.com>
Date: Tue, 21 Apr 2009 12:06:47 -0700
Message-ID: <dd18b0c30904211206l39f6224fq9f602d7f9a6e8639@mail.gmail.com>
Subject: Re: newrole and pam.d/*
From: Justin Mattock <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 21, 2009 at 7:13 AM, Justin Mattock <justinmattock@gmail.com> wrote:
> On Tue, Apr 21, 2009 at 4:53 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Mon, 2009-04-20 at 16:10 -0700, Justin Mattock wrote:
>>> quick question:
>>> Is there a way to configure pam.d/*
>>> for a one time password for the session, so when I use newrole
>>> I don't have to give a password each time?
>>>
>>> The reason for this is, is I'm trying to
>>> configure all of my apps in the menu bar of
>>> fluxbox, so when I click on any app in there
>>> the app will automatically open in the specified role.
>>> (rather than opening a terminal etc...)
>>
>> You can use /etc/selinux/newrole_pam.conf to specify a different pam
>> configuration for specific applications.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>
> hmm... weird, I'm must have built
> pam/shadow wrong(not reading
> /etc/selinux/newrole_pam.conf
> In any case I'll try and see If I can get away
> with having nothing in the file(or look for something
> that's responsible for taking the original session paswd
> and remembering it for the rest of the session)
>
> This way it makes life easier,
>
> --
> Justin P. Mattock
>

After looking at my situation, I seem to be
stuck at how/or why newrole is not reading /etc/selinux/newrole_pam.conf.
(all development headers are there)
seems it's going directly to /etc/pam.d/newrole, instead of /etc/selinux/*
Also is there something new
with newrole having to have libprelude in order to install?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
