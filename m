Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Verify the integrity of downloaded archives
Date: Fri, 7 Nov 2003 13:13:32 -0500
Cc: SELinux@tycho.nsa.gov
References: <000001c3a3db$2dad18f0$02000a0a@lady> <200311060111.16197.wlsel@verizon.net> <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200311071313.32442.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thursday 06 November 2003 09:24 am, Stephen Smalley wrote:
> On Thu, 2003-11-06 at 01:11, Bill Laut wrote:
> > While I'd love to meet a hacker who could successfully break into the
> > NSA's website to install a Trojan (;-), Oliver does bring up a good
> > point.  As SELinux gains a wider audience it would be reasonable to
> > anticipate the distro eventually getting mirrored at other sites.  Since
> > the use of digital signatures as an integrity-check is now commonplace
> > within the Linux community, would it be reasonable to start posting
> > signatures on the NSA website?
>
> Possibly.  Since we originally released SELinux as a proof of concept /
> reference implementation and it has never been intended to be a Linux
> distribution unto itself (although it can be incorporated into one),
> this hasn't been a major concern in the past.  However, I understand the
> concern.  On the other hand, on what basis would you trust the key used
> to sign the archives and patches?
>

I'm not certain what you mean by "trust."  If you're implying a CA like 
Verisign, no way.  Firstly, that would be overkill.  Secondly, the idea of 
NSA going to Verisign for credentials is, well, politically distasteful to 
say the least and would undoubtedly engender all sorts of unintended 
consequences, political and otherwise.

As to the trustworthiness of the algorithms, I'm not aware of successful 
published attacks on DSA, et al.  The only one that comes to mind is RC5 
which IIRC a German cryptogapher nearly all but broke back around 1996.  If 
anyone has better knowledge please feel free to post it.

As for "trust" defined by the security of the NSA's website, well, that was 
why I put the "winking-face" icon after my opening sarcasm:  If there's one 
website that's "hacker-proof," it is the NSA's home page and which is why I 
and undoubtedly others chuckled at Oliver's innocent cheek.

I understand what you said about SELinux being a research project that was 
never intended as a Linux distro unto itself.  Perhaps my use of "distro" was 
a poor choice to describe the two-part downloads of the patched kernel and 
userland archive.  Nevertheless, now that it's mainstreamed as of v2.6 
SELinux is going to gain a much wider audience and as it does it will explode 
worldwide throughout the Linux community.  (As a former free-lance consultant 
I haven't seen "bottled lightning" this potent since the Internet achieved 
critical mass around 1991/92, but that's for another thread.)

While I believe anyone is secure in downloading SELinux from the NSA's 
website, as Jim mentioned there's already enough interest in it that other 
websites have begun mirroring SELinux.  And therein lies the problem.  As 
SELinux's popularity grows it will eventually come under attack by whoever 
has an agenda to push, if only because it carries the NSA's imprimatur.  If 
they can't attack it on the NSA's website they'll go to other, less secure 
mirrors to do so.  Therefore, in order to pre-empt all of that I'm 
questioning if now wouldn't be the appropriate time to consider some sort of 
digital signing strategy.

Anyway, to finish answering your question concerning key trust:  It wouldn't 
have to be complicated.  Perhaps nothing more than just the usual PGP 
detached signature, one for each download, with the signing done on an 
air-gapped PC and the public key and sigs distributed on the NSA's website, 
with the public key included in the patched kernel's Documentation directory 
as distributed by www.kernel.org and/or maybe uploaded to a number of public 
keyservers.

Does this sound reasonable?  Am I forgetting or overlooking anything?

Bill



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
