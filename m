Date: Wed, 8 Jun 2005 12:09:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: brandon-pollet@utulsa.edu
cc: SELinux@tycho.nsa.gov
Subject: Re: Dynamic Policy Enforcement in SELinux
In-Reply-To: <1118094711.42a4c577888fb@cc.utulsa.edu>
Message-ID: <Xine.LNX.4.44.0506081157030.29266-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 6 Jun 2005 brandon-pollet@utulsa.edu wrote:

> My name is Brandon Pollet and I am a part of the Enterprise Security
> Research Group at the University of Tulsa. I recently finished my
> graduate thesis on Security Enhanced Linux Dynamic Policy Enforcement
> and I wanted to share it with the community to get your feedback. I have
> included a link to my thesis in dvi format but, if there is interest, I
> can also provide a link for postscript or PDF. If you have any questions
> or feedback please send it to the address below I would love to hear
> what you all think. Thank you.

This scheme seems to place a large burden on the administrator, to set up 
the rules in the first place and then to analyze and respond to events.

The burden would be amplified by having to manage this across a large 
network of systems.

In terms of initial configuration, how does the administrator even know
what to care about? 

You mention that it's a potential DoS vector, although the later examples
provided don't seem to demonstrate clearly how the change in security
posture of the system (e.g. disabling ssh access) to an
attacker-controlled event (e.g. portscan) provides a good risk/benefit
scenario.  Why is it better in this case to disable ssh?  Could be a good
way to lock the administrator out of the system while you break in via 
ftpd.

How do you know what the attack signature means?



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
