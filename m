Date: Fri, 17 Aug 2001 00:12:26 +0100
From: Dale Amon <amon@vnl.com>
To: John Scroggins <dataefx@earthlink.net>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [Fwd: Partial TOC for Comment]
Message-ID: <20010817001226.J18183@vnl.com>
References: <3B7C7C69.E7B84C68@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B7C7C69.E7B84C68@earthlink.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, Aug 16, 2001 at 07:07:37PM -0700, John Scroggins wrote:
> Please give me your feedback/critique on the TOC, and if you can think
> of additional subject headings (I do have more, but I want to see if
> this is moving in the right directiom..)
> 

I'd suggest a spell checker :-)

Presumably the first sections will be a discussion of the why and
of the threat model and how SELinux secures you against those
classes of threats.

My personal feeling is that this sort of discussion throughout
will be important. I don't expect SELinux will protect against
all possible threats and it would be bad for someone new to
computer security to read a book, install it, and start
bragging. 

I'd say that a good section should be set aside to interpreting
log information. Having a "secure" system does you no good if
you just let the kiddies and the black hats tinker undisturbed.
Given peace and quiet and enough time, I'm sure *anyone* can
break into *anything*.

I find the idea of real time revokation interesting, because if
you see signs of an attack in progress, you can pull the rug
right out from under it... but again, only if you *realize* it
is an attack.

Some of these issues become much more complex in a public system
than in a closed system. In a closed and controlled environment
almost anything out of the ordinary is suspicious; and innocent
triggering is fairly easy to spot.

In summary, I think you need to tell not only how to set it up
and configure it and what the theory is behind it, but also
how to use it.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
