Date: Tue, 29 Jan 2002 08:18:39 -0800
From: Paul Krumviede <pwk@acm.org>
To: SELinux@tycho.nsa.gov
Subject: file labeling (was Re: applications and ports)
Message-ID: <95876102.1012292319@localhost>
In-Reply-To: <Pine.GSO.4.33.0201290944230.11892-100000@raven>
References: <Pine.GSO.4.33.0201290944230.11892-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Tuesday, 29 January, 2002 10:32 -0500 Stephen Smalley 
<sds@tislabs.com> wrote:

> You also need to assign the program type
> associated with the domain to the program in the file_contexts
> configuration and run 'make relabel' in the setfiles directory.
> Alternatively, you can directly set the label on a program via chcon, but
> it is a good idea to also update the file_contexts configuration in case
> you later do a 'make relabel'.

i would emphasize this last sentence, as i've confused myself by
failing to track manually labeled files in file_contexts only to have
policy changes fail to work unexpectedly after i'd relabel the
file system.

as an aside, the default install for file-utils in the latest release
doesn't seem to install the chcon man page, so i didn't find
the option to not dereference symbolic links for a bit.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
