Subject: Re: SEAndroid app data labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: jwcart2@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4F205DAC.3010100@manicmethod.com>
References: <4F201BE3.1020603@manicmethod.com>
	 <1327516014.9496.8.camel@moss-lions.epoch.ncsc.mil>
	 <1327517766.9496.21.camel@moss-lions.epoch.ncsc.mil>
	 <4F205DAC.3010100@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Jan 2012 15:50:44 -0500
Message-ID: <1327524644.13448.4.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-01-25 at 14:53 -0500, Joshua Brindle wrote:
> James Carter wrote:
> >> >
> > Did you wipe everything when you did the install? (The "-w" in "fastboot
> > -w flashall" causes user data to be erased.)
> >
> > At this point in the project, any existing app data would have to be
> > manually labeled.
> >
> 
> I do -w every time. I'll try to figure out what is going on.

FWIW, installd is the program that does the labeling of the app data
directories.

When did you last do a repo sync?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
