Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6AFUl6r017846
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 11:30:47 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6AFUkpm023498
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 15:30:46 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1375925fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 08:30:45 -0700 (PDT)
Message-ID: <cadfc0e40807100830g62baf4f6s19559c0c1ee2144b@mail.gmail.com>
Date: Thu, 10 Jul 2008 10:30:45 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: newrole assertion - should be gnome-terminal assertion
Cc: "SELinux List" <selinux@tycho.nsa.gov>, "Joe Nall" <joe@nall.com>
In-Reply-To: <1215691771.31554.34.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com>
	 <1215617024.24864.28.camel@moss-spartans.epoch.ncsc.mil>
	 <4875026A.3040104@gmail.com>
	 <cadfc0e40807091517k2a40dcecl90c99bd8e971685a@mail.gmail.com>
	 <1215691771.31554.34.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 10, 2008 at 7:09 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Wed, 2008-07-09 at 17:17 -0500, Xavier Toth wrote:
>> On Wed, Jul 9, 2008 at 1:24 PM, Ted X Toth <txtoth@gmail.com> wrote:
>> > Stephen Smalley wrote:
>> >>
>> >> On Tue, 2008-07-08 at 14:02 -0500, Xavier Toth wrote:
>> >>
>> >>>
>> >>> Using MLS enforcing in a gnome-terminal with context
>> >>> user_u:user_r:user_t:s0-s15:c0.c1023 I run newrole and get these
>> >>> results
>> >>>
>> >>> newrole -l s1-s1 -- -c "gnome-terminal --disable-factory"
>> >>> Password:
>> >>> **
>> >>> ** ERROR:(terminal.c:1016):new_terminal_with_options: assertion
>> >>> failed: (profile)
>> >>>
>> >>>
>> >>> I think Joe straced this and has a little more info if he'd like to chime
>> >>> in.
>> >>>
>> >>
>> >> So, I assume that this does not happen if in permissive mode?
>> >> What AVC denials occur?  Run semodule -DB and retry if there are no AVCs
>> >> by default.
>> >>
>> >> What is the application trying to do at that point (look at the source
>> >> code and/or ask on the gnome lists)?  What are the possible failure
>> >> conditions there?  What external dependencies does it have?
>> >> strace output might help if you have it.
>> >>
>> >>
>> >
>> > Sorry to have bothered you. Looks like it has something to do with
>> > polyinstantiation of ~/.gnome or ~/.gnome2. We haven't seen this with
>> > previous versions even when polyinstantiating :(
>> >
>> >
>>
>> Hmmm this was a bit of a rush to judgment :( It actually turned out
>> that if I don't polyinstantiate /tmp then I can start gnome-terminal
>> as shown in permissive but it still doesn't work in enforcing. I tried
>> turning off dontaudit but I'm not seeing any  AVC out of
>> gnome-terminal. I've attached a strace maybe you'll see something that
>> I don't.
>
> Look for any avcs at all - they might be occurring during the
> polyinstantiation, or from dbus, or from the X server.
>
> Also, run the strace while permissive and diff the two strace outputs to
> see how they differ (imperfect, there will be noise, but helpful
> nonetheless).
>
> I see quite a few ENOENTs in there, e.g. on the .gnome2 files, not sure
> how many of those are expected/harmless.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Comparing straces when gnome-ternimal fails to start there is a
problem with it talking to dbus (~line 1062 of the trace I attached
previously).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
