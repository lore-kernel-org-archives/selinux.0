Message-ID: <3FAAD11A.9030608@hotmail.com>
Date: Thu, 06 Nov 2003 22:54:18 +0000
From: James de Lurker <jtl2nospamMUNGIEjump@hotmail.com>
Reply-To: see.the.sig.2.reply.by.email.offlist@hotmail.com
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Verify the integrity of downloaded archives
References: <000001c3a3db$2dad18f0$02000a0a@lady>	 <200311060111.16197.wlsel@verizon.net> <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> On Thu, 2003-11-06 at 01:11, Bill Laut wrote:

[..]

>>SELinux gains a wider audience it would be reasonable to anticipate the 
>>distro eventually getting mirrored at other sites.

It already is! I frequently use the "Wiretapped" Australian site as a
convenient place that centralises security related stuff. Recommended.

   ftp://ftp.wiretapped.net/pub/security/operating-systems/selinux/
   http://www.wiretapped.net/


>>.............................................  Since the use of digital 
>>signatures as an integrity-check is now commonplace within the Linux 
>>community, would it be reasonable to start posting signatures on the NSA 
>>website?

A list of MD5s against files, itself wrapped in a digital signature would 
be extremely useful. Authentication is nice, to eliminate the possible of
MiM attacks on ftp delivery ( or directly compromised ftp services, as has
already happened, with some key open source applications ).

For the most part, integrity checking against accidental damage rather than 
malicious tampering is needed. Even better - "par" Reed Solomon matrix
error correction files in the file groups are a great way of checking 
against storage media degradation. Fix the damage rather than only detect
it after downloading a particularly large archive file, or ISO image.

    http://parchive.sourceforge.net/


[..]
>...........On the other hand, on what basis would you trust the key used
> to sign the archives and patches?
> 

Not perfect, but a "Web of Trust" that incorporated contributors I've met.
Russell, to name but one. A separate "site key" that had such authority,
with appropriate disclaimers for the NSA's purposes of course... Reasonably 
confident that a suitable exchange protocol could be established by private
email from the regulars that have met in person, to make remote key signing
exchanges of a site signature key viable.

How does that sound?

-- 

   -- James

 From and Reply To are INVALID.

All public postings use munged headers[1]- To contact me off list:
   1) Remove "M U N G I E j u m p" ONLY: leave that "nospam" in there!
   2) change "hotmail" 2 "myrealbox" after the @



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
