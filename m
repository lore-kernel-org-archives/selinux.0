MIME-Version: 1.0
In-Reply-To: <1237216373.1035.1.camel@localhost.localdomain>
References: <cadfc0e40903140914n681c634fw5945242dab71f139@mail.gmail.com>
	 <cadfc0e40903151003l367d0f73j8a45e3332fe44763@mail.gmail.com>
	 <1237216373.1035.1.camel@localhost.localdomain>
Date: Mon, 16 Mar 2009 16:13:38 +0000
Message-ID: <cadfc0e40903160913k16b3e1a1i3e63ee2e445aa56a@mail.gmail.com>
Subject: Re: adding LANG and XMODIFIER to newrole minimal environment
From: Xavier Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 16, 2009 at 3:12 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2009-03-15 at 17:03 +0000, Xavier Toth wrote:
>> On Sat, Mar 14, 2009 at 4:14 PM, Xavier Toth <txtoth@gmail.com> wrote:
>> > Stephan,
>> > What would you think of adding LANG and XMODIFIER to newroles minimal
>> > environment for internationalization support? Alternatively maybe
>> > newrole could support an option which is a list of env variables to
>> > maintain.
>> >
>> > Ted
>> >
>>
>> Possible patch:
>
> Why not just use newrole -p in that case?
>
> --
> Stephen Smalley
> National Security Agency
>
>

Because there are other env variables that mess up processes you are
trying to run at a specific level like DBUS_SESSION_BUS_ADDRESS.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
