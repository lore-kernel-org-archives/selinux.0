Subject: Re: newrole and pam.d/*
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30904201610s5248e8e1w69f10aa7ad452911@mail.gmail.com>
References: <dd18b0c30904201610s5248e8e1w69f10aa7ad452911@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Apr 2009 07:53:58 -0400
Message-Id: <1240314838.1678.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 16:10 -0700, Justin Mattock wrote:
> quick question:
> Is there a way to configure pam.d/*
> for a one time password for the session, so when I use newrole
> I don't have to give a password each time?
> 
> The reason for this is, is I'm trying to
> configure all of my apps in the menu bar of
> fluxbox, so when I click on any app in there
> the app will automatically open in the specified role.
> (rather than opening a terminal etc...)

You can use /etc/selinux/newrole_pam.conf to specify a different pam
configuration for specific applications.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
