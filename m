Date: Mon, 21 Jan 2002 09:15:53 +0100
From: Tom <tom@lemuria.org>
To: Lonnie Cumberland <lonnie@outstep.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: restricted guest domain accounts
Message-ID: <20020121091553.A28411@lemuria.org>
References: <1129.192.168.1.12.1011589591.squirrel@mail.outstep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129.192.168.1.12.1011589591.squirrel@mail.outstep.com>; from lonnie@outstep.com on Mon, Jan 21, 2002 at 12:06:31AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 21, 2002 at 12:06:31AM -0500, Lonnie Cumberland wrote:
> If I now go along the lines that I will not isolate the users to
> their home directories but instead use the most secure OS for the job
> then I once again arrive back at SELinux which I am starting to like
> more and more.

I have a very similiar problem. I need a remote-access server with
multiple "public" access options (internet, analog and ISDN dialups)
into a highly sensitive backend network. obviously, I *expect* it to be
a target not only for the usual script kiddie rounds, but also for
specific attacks from people who know at least the rough setup, maybe
even insiders. the data stored on the backend is such that it may be of
private interest to even the people who work with it (but obviously
can't copy it overtly during worktime).

so for now - because as usual nobody really realizes that remote access
into your own backend means a little more than a convenience, and
there's of course a tight deadline - I'm using a locked-down, minimalistic 
Debian system.
however, I would just love to lock it down much more. that's where
SELinux comes into play, because I believe here I can really put a
policy into play that says "after successful login, you are allowed to
execute exactly THESE three programs."
as a matter of fact, I wouldn't mind blocking a selection of system
calls that I know won't be needed. :)


> What I am not looking to do is to humbly ask for some help from the
> list to create a guest domain so that I can add new users to and they
> will have very restricted abilities on the server. A simple example
> would be great if someone might have one to share with me.

yes, please. I need a similiar example. I still have trouble
understanding the flask concept details. I do believe I have the basics
down (after 3rd reading), but I don't feel confident writing a policy,
yet.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
