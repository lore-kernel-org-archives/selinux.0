MIME-Version: 1.0
In-Reply-To: <1233679082.14235.21.camel@localhost.localdomain>
References: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com>
	 <1233679082.14235.21.camel@localhost.localdomain>
Date: Tue, 3 Feb 2009 13:59:57 -0600
Message-ID: <cadfc0e40902031159r55a12a02u46b0dde8f9356460@mail.gmail.com>
Subject: Re: odd policy behavior
From: Xavier Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 3, 2009 at 10:38 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2009-02-03 at 10:28 -0600, Xavier Toth wrote:
>> I have an app that wasn't working in enforcing but there are no AVCs.
>> So I did 'semodule -DB' to see if there were any dontaudit denials and
>> restarted the app. The problem is that the app then ran fine. So I
>> tried load_policy which had no affect and 'semodule -B' which makes it
>> work. Any ideas what could be happening? I've verified with 'semodule
>> --list' that the module is loaded prior to doing the 'semodule -B'.
>
> - How was the app failing?

This is our security banner app that draw a window across the top of
the screen with the users MLS range and with the appropriate
background color. When it fails there is just a window with a gray
background no text or color.

> - Did you try running the app in permissive as well?
> - Is this reproducible at all or are you unable to reproduce the
> application failure now under any conditions?
> - Did the app create/use any transient resources (temporary files,
> system v ipc objects, etc) that could have prevented it from succeeding
> on subsequent execution if they weren't properly cleaned up on prior
> exit?

After further investigation I found that a call to getseuserbyname for
the login user is returning the user name passed in and nothing for
the range which would be used in the banner. During our installation
we don't explicitly map this user to a SELinux user but our experience
has been that the when there is no mapping the user and range of the
'__default__' login are returned. Indeed once I rebuild policy this
appears to be what is happening. How rebuilding and reloading policy
would affect this is unclear.

>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
