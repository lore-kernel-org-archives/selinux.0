Message-ID: <4B268E72.3030908@gmail.com>
Date: Mon, 14 Dec 2009 11:13:54 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>,
        xorg@freedesktop.org, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>	 <4B2677DF.6060801@tycho.nsa.gov> <cadfc0e40912141039p663a94aenf7094946736a834c@mail.gmail.com>
In-Reply-To: <cadfc0e40912141039p663a94aenf7094946736a834c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Sounds to me like Justin needs the QueryPointer spoofing code.
>
> Ted
>

I cut the thread to clean it up a bit.

As for QuearyPointer not sure exactly
what that is. a quick Google showed
something about root window or something.
(similar to the avc's I've been seeing);

In any case what I'm doing here is I have one machine
setup with monolithic, and then another machine will
be a binary policy(just need to setup semanage user *)

Then if I get any of these left over avc's I'll
put them under dontaudit and basically forget
about them.

looking at the git log there was some new stuff commited
towards the xserver, So within the next few days I might
as well pull all the xserver stuff, then go from there.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
