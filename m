Message-ID: <002f01c12743$52700650$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: <SELinux@tycho.nsa.gov>
References: <3B7C7C69.E7B84C68@earthlink.net> <20010817001226.J18183@vnl.com>
Subject: Re: [Fwd: Partial TOC for Comment]
Date: Fri, 17 Aug 2001 10:37:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I don't expect SELinux will protect against all possible threats ...
A chapter on SELinux scope would be helpful here. Listing additional
references, tools & techniques that
can be used along with SELinux to help find and plug the holes.

Also a scenarios section would be nice too. For instance "Building
Firewalls" has a whole chapter on different configurations. I want to set up
two configurations, a secured server running http & smtp, and a dual homed
firewall. The kinds of questions in my mind are "is there a better way that
I could be doing this?", "am I setting this up correctly?, did I miss
something ...?". For instance if it was just as secure to stick a second nic
into the server and make it the gateway as well, then I could spend more
effort on the one machine.

----- Original Message -----
From: "Dale Amon" <amon@vnl.com>
To: "John Scroggins" <dataefx@earthlink.net>
Cc: <SELinux@tycho.nsa.gov>
Sent: Thursday, August 16, 2001 4:12 PM
Subject: Re: [Fwd: Partial TOC for Comment]


>
> On Thu, Aug 16, 2001 at 07:07:37PM -0700, John Scroggins wrote:
> > Please give me your feedback/critique on the TOC, and if you can think
> > of additional subject headings (I do have more, but I want to see if
> > this is moving in the right directiom..)
> >
>
> I'd suggest a spell checker :-)
>
> Presumably the first sections will be a discussion of the why and
> of the threat model and how SELinux secures you against those
> classes of threats.
>
> My personal feeling is that this sort of discussion throughout
> will be important. I don't expect SELinux will protect against
> all possible threats and it would be bad for someone new to
> computer security to read a book, install it, and start
> bragging.
>
> I'd say that a good section should be set aside to interpreting
> log information. Having a "secure" system does you no good if
> you just let the kiddies and the black hats tinker undisturbed.
> Given peace and quiet and enough time, I'm sure *anyone* can
> break into *anything*.
>
> I find the idea of real time revokation interesting, because if
> you see signs of an attack in progress, you can pull the rug
> right out from under it... but again, only if you *realize* it
> is an attack.
>
> Some of these issues become much more complex in a public system
> than in a closed system. In a closed and controlled environment
> almost anything out of the ordinary is suspicious; and innocent
> triggering is fairly easy to spot.
>
> In summary, I think you need to tell not only how to set it up
> and configure it and what the theory is behind it, but also
> how to use it.
>
>
>
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
