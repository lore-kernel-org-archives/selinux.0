Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00380
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 12:49:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA09737
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 17:47:59 GMT
Received: from mail.thesportsregister.com (mail.thesportsregister.com [208.53.250.138])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA09733
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 17:47:58 GMT
Date: Mon, 15 Jan 2001 12:53:07 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: Jan Petranek <jan@petranek.de>
Cc: selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root 
In-Reply-To: <01011516091701.13938@linux16>
Message-ID: <Pine.LNX.4.21.0101151209240.18288-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi,

   If someone on the SELinux team sees any mistakes in what I'm saying,
feel free to correct me.

   SELinux, as I understand it, uses mandatory access controls. To me,
this implies that NO user, including the superuser, has automatic right
of access, except in those specific cases where access is explicitly 
granted. ie: the default is to deny access. (The Dead Man's Handle.)

   This would imply that, in the event of a successful root attack, the
attacker would be limited in what they could see, and limited in what they
could set themselves able to see.

   The "ultimate" in this path is to have no concept of a
super-user. Then, attacking one username is as good as attacking
another. There isn't one ripe target that's necessarily vulnerable AND
powerful.

   Yes, you -can- hide hardware, put on tamper-proof locks, et al, but
those are really useless for security, as the main source of attacks is
from the INside. (This has been true, ever since "Hugo Cornwall" wrote the
"Hacker's Handbook".) Security comes from within, not without. In other
words, security shouldn't be a matter of which direction the enemy comes
from. It should still be there. Holding the hard-disk must be as useless
as holding the IP address. Otherwise, you're vulnerable.

   As for encryption, you make the assumption of a static key. A rolling
key, where the key value is some arbritary function of the previous key,
location on disk, user profile, etc, and other random data, means that any
crack in the encryption ONLY reveals data from the point of crack onwards,
provided the cracker has the algorithm and ALL necessary rolled-over
data. This essentially means that, for incomplete information, a cracker
would never be 100% sure they -had- cracked the data, as multiple
"valid" translations would exist.

   THAT is the key to good encryption, IMHO. Anyone can crack a code, IF
they know how to tell if they -have- cracked it. As soon as you get many
possible translations, all of which "work", then you're down to guesswork
as to which one is "real". And the more "valid" translations you can get,
the worse it'll be. By using a randomly-shifting key, where the shift is
deterministic but non-predictable (ie: chaotic), and functions which are
sensitive to initial conditions, you can make it impractical for a cracker
to guess which of the N decrypts is meaningful.


Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
